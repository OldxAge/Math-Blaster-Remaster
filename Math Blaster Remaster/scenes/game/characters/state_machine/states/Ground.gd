extends PlayerState

var running = false
var crawling = false


func enter() -> void:
	player._current_state = "WALKING"


func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player._can_jump = false
		state_machine.transition_to("Air")
		return

	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if(x_input != 0):
		player._animation_player.flip_h = x_input < 0
	if(running):
		player.velocity.x = lerp(player.velocity.x, x_input * player.RUN_SPEED, player.MVMT_ACCELERATION * delta)
	elif(crawling):
		player.velocity.x = lerp(player.velocity.x, x_input * player.CRAWL_SPEED, player.MVMT_ACCELERATION * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, x_input * player.WALK_SPEED, player.MVMT_ACCELERATION * delta)
	player.velocity.y = lerp(player.velocity.y, player.GRAVITY, player.AIR_RESISTANCE * delta)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	# Sprint Check
	if Input.is_action_pressed("run"):
		running = true
		player._animation_player.play("running")
		player._current_state = "RUNNING"
	elif Input.is_action_just_released("run"):
		running = false
	
	# Crawl Check
	if Input.is_action_pressed("crawl"):
		crawling = true
		player._animation_player.play("crawling")
		player._current_state = "CRAWLING"
	elif Input.is_action_just_released("crawl"):
		crawling = false
	
	if not running and not crawling:
		player._animation_player.play("walking")
		player._current_state = "WALKING"
	
	# State Transition if statements
	if Input.is_action_just_pressed("jump") and player._can_jump:
		state_machine.transition_to("Air")
	elif (Input.is_action_just_pressed("move_up")):
		BulletSpawner.spawnBullet(player._fire_point.get_global_position(), player.hazardType)
#	elif (Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down")) and player._can_climb:
#		state_machine.transition_to("Climb", {do_climb = true})
	elif is_equal_approx(x_input, 0.0):
		state_machine.transition_to("Idle")
