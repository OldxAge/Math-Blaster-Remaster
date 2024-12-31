extends PlayerState

var hovering = false
var pressed = false


func enter() -> void:
	player._current_state = "FALLING"
	if player._can_jump:
		player.velocity.y = player.JUMP_SPEED
		pressed = true
	player._animation_player.play("falling")
	player._can_jump = false
	player._can_hover = true
	player._can_crawl = false


func physics_update(delta: float) -> void:
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if(x_input != 0):
		player._animation_player.flip_h = x_input < 0
	
	if(hovering and player._can_hover):
		player.velocity.x = lerp(player.velocity.x, x_input * player.WALK_SPEED, player.MVMT_ACCELERATION * delta)
		player.velocity.y = lerp(player.velocity.y, player.HOVER_SPEED, player.HOVER_ACCELERATION * player.AIR_RESISTANCE * delta)
		player.useHoverFuel()
	else:
		player.velocity.y = lerp(player.velocity.y, player.GRAVITY, player.AIR_RESISTANCE * delta)
		if(player._hover_fuel < player.MAX_FUEL_LEVEL):
			player.rechargeHoverFuel(player.FUEL_RECHARGE_RATE_AIR)
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity

	# Landing.
	if player.is_on_floor():
		player._can_jump = true
		if is_equal_approx(x_input, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Ground")
	
	if Input.is_action_just_pressed("jump") and !pressed and player._can_hover:
		hovering = true
		player._animation_player.play("hovering")
		player._current_state = "HOVERING"
	elif Input.is_action_just_released("jump"):
		hovering = false
		pressed = false
		player._animation_player.play("falling")
		player._current_state = "FALLING"
	elif (Input.is_action_just_pressed("move_up")):
		BulletSpawner.spawnBullet(player._fire_point.get_global_position(), player.hazardType)
#	elif (Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down")) and player._can_climb:
#		state_machine.transition_to("Climb", {do_climb = true})
