extends PlayerState

var surfaced
var swimming

func enter() -> void:
	player._current_state = "SWIMMING"
	player._animation_player.play("swimming")


func physics_update(delta: float) -> void:
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	player.velocity.x = lerp(player.velocity.x, x_input * player.SWIM_SPEED, player.SWIM_ACCELERATION * delta)
	if swimming:
		player.velocity.y = lerp(player.velocity.y, -player.SWIM_SPEED, player.SWIM_ACCELERATION * delta)
	else:
		player.velocity.y = lerp(player.velocity.y, player.GRAVITY, player.WATER_RESISTANCE * delta)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	# State Transition if statements
	if Input.is_action_pressed("jump") and surfaced:
		player._can_jump = true
		swimming = false
		state_machine.transition_to("Air")
	elif Input.is_action_pressed("jump") and !surfaced:
		swimming = true
