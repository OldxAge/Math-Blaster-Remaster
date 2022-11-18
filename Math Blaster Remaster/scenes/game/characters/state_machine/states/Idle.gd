extends PlayerState


func enter() -> void:
	player._current_state = "IDLE"
	player._animation_player.play("idling")
	player.velocity = Vector2.ZERO
	player._can_jump = true
	player._can_hover = false
	player._can_crawl = true


func update(delta: float) -> void:
	# If you have platforms that break when standing on them, you need that check for 
	# the character to fall.
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Ground")
	elif Input.is_action_just_pressed("jump") and player._can_jump:
		state_machine.transition_to("Air")
	elif (Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down")) and player._can_climb:
		state_machine.transition_to("Climb")
