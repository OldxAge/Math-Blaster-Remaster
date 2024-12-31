extends PlayerState


func enter() -> void:
	player._current_state = "CLIMBING"
	player._animation_player.play("climbing")


func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	
	if(player._hover_fuel < player.MAX_FUEL_LEVEL):
		player.rechargeHoverFuel()
	
	player.velocity.x = lerp(player.velocity.x, x_input * player.CLIMB_SPEED, player.MVMT_ACCELERATION * delta)
	player.velocity.y = lerp(player.velocity.y, y_input * player.CLIMB_SPEED, player.MVMT_ACCELERATION * delta)
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
	
	# If player stops moving on ladder, animation stops
	if(!player._animation_player.playing and (x_input != 0 or y_input != 0)):
		player._animation_player.playing = true
	
	# State Transition if statements
	if Input.is_action_just_pressed("jump") and player._can_jump:
		state_machine.transition_to("Air")
	elif player.is_on_floor():
		player._can_jump = true
		if is_equal_approx(x_input, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Ground")
	elif is_equal_approx(x_input, 0.0) and is_equal_approx(y_input, 0.0):
		player._animation_player.playing = false
