class_name Player
extends KinematicBody2D
# Player Movement, Behavior script

signal state_changed()


const MVMT_ACCELERATION = 20
const HOVER_ACCELERATION = 2
const MAX_SPEED = 64
const SWIM_SPEED = 48
const FRICTION = 2

const MAX_FORCE = 256
const WALK_SPEED = 64
const RUN_SPEED = 128
const CRAWL_SPEED = 32

const GRAVITY = 128
const JUMP_FORCE = -200
const HOVER_SPEED = -160
const SWIM_FORCE = 32
const CLIMB_FORCE = 64
const NO_FORCE = 0
const AIR_RESISTANCE = 2

var velocity = Vector2.ZERO
var speed

onready var _animation_player = $AnimatedSprite
var _current_state
var _can_crawl
var _can_jump
var _can_hover
var _can_climb


var _y_action_force = 0

onready var sprite = $AnimatedSprite


func _physics_process(delta):
	speed = velocity


func getSpeed():
	return speed

func getCurrentState():
	return _current_state
