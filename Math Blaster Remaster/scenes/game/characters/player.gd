class_name Player
extends KinematicBody2D
# Player Movement, Behavior script

signal state_changed()

enum PlayerState {JUMPING, HOVERING, WALKING, SWIMMING, CLIMBING}

const TARGET_FPS = 60
const ACCELERATION = 512
const MAX_SPEED = 64
const SWIM_SPEED = 48
const FRICTION = 2

const MAX_FORCE = 256
const GRAVITY = 128
const JUMP_FORCE = 1200
const HOVER_FORCE = 128
const SWIM_FORCE = 32
const CLIMB_FORCE = 64
const NO_FORCE = 0
const AIR_RESISTANCE = 2

var speed

var _current_state = PlayerState.WALKING
var _can_jump
var _can_hover
var _velocity = Vector2.ZERO

var _y_action_force = 0

onready var sprite = $AnimatedSprite


func _physics_process(delta):
	var new_velocity = Vector2.ZERO
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if x_input != 0:
		new_velocity.x += x_input * ACCELERATION * delta * TARGET_FPS
	if y_input != 0:
		new_velocity.y = y_input * delta * TARGET_FPS
	
	match _current_state:
		PlayerState.JUMPING:
			_can_jump = false
			_can_hover = true
			new_velocity.x = _velocity.x
			_y_action_force = -JUMP_FORCE
			$AnimatedSprite.play("jumping")
		PlayerState.HOVERING:
			_can_jump = false
			_can_hover = true
			y_input = -1
			if x_input != 0:
				sprite.flip_h = x_input < 0
			_y_action_force = -HOVER_FORCE 
			sprite.flip_h = x_input < 0
			$AnimatedSprite.play("hovering")
		PlayerState.WALKING:
			_can_jump = true
			_can_hover = true
			if x_input != 0:
				sprite.flip_h = x_input < 0
				$AnimatedSprite.play("walking")
			else:
				$AnimatedSprite.play("idle")
			_y_action_force = NO_FORCE
		PlayerState.SWIMMING:
			_can_jump = false
			_can_hover = false
			if x_input != 0:
				sprite.flip_h = x_input < 0
			if y_input != 0:
				_y_action_force = SWIM_FORCE
			$AnimatedSprite.play("swimming")
		PlayerState.CLIMBING:
			_can_jump = true
			_can_hover = true
			if y_input != 0:
				_y_action_force = CLIMB_FORCE
			$AnimatedSprite.play("climbing")
	
	_velocity.x = new_velocity.x
	new_velocity = Vector2.ZERO
	
	if x_input != 0:
		_velocity.x = clamp(_velocity.x, -MAX_SPEED, MAX_SPEED)
	else:
		_velocity.x = lerp(_velocity.x, 0, FRICTION * delta)
	
	if y_input != 0:
		if _velocity.y < 0:
			_velocity.y = clamp(_velocity.y + _y_action_force + GRAVITY, -MAX_FORCE, MAX_FORCE)
		else:
			_velocity.y = clamp(_velocity.y + _y_action_force * 2 + GRAVITY, -MAX_FORCE, MAX_FORCE)
		print(_velocity)
	else:
		_velocity.y = lerp(_velocity.y, GRAVITY, AIR_RESISTANCE * delta)
	

	if is_on_floor() and _current_state != PlayerState.SWIMMING:
		_current_state = PlayerState.WALKING

	_velocity = move_and_slide(_velocity, Vector2.UP)
	
	speed = _velocity

func _input(event):
	if event.is_action_pressed("jump") and _can_jump:
		_current_state = PlayerState.JUMPING
	elif Input.is_action_pressed("jump") and !_can_jump and _can_hover:
		_current_state = PlayerState.HOVERING
	elif Input.is_action_just_released("jump"):
		_current_state = PlayerState.JUMPING

func getSpeed():
	return speed

func getCurrentState():
	return PlayerState.keys()[_current_state]
