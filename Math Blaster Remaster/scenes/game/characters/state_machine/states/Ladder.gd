extends PlayerState

# Upon entering the state, print a message
func enter() -> void:
	player._current_state = "CLIMBING"
	player._animation_player.play("climbing")


func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air" , {do_jump = true})
		return

	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	
	player.velocity.x = lerp(player.velocity.x, x_input * player.WALK_SPEED, player.MVMT_ACCELERATION * delta)
	player.velocity.y = lerp(player.velocity.y, y_input * player.CLIMB_FORCE, player.MVMT_ACCELERATION * delta)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	# If player stops moving on ladder, animation stops
	if(!player._animation_player.playing and (x_input != 0 or y_input != 0)):
		player._animation_player.playing = true
	
	# State Transition if statements
	if Input.is_action_just_pressed("jump") and player._can_jump:
		state_machine.transition_to("Air", {do_jump = true})
	elif player.is_on_floor():
		if is_equal_approx(x_input, 0.0) and is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Ground")
	elif is_equal_approx(player.velocity.x, 0.0) and is_equal_approx(player.velocity.y, 0.0):
		player._animation_player.playing = false
