class_name Player
extends KinematicBody2D


signal state_changed()

const MVMT_ACCELERATION = 20
const HOVER_ACCELERATION = 2
const SWIM_ACCELERATION = 20
const AIR_RESISTANCE = 2
const WATER_RESISTANCE = 2
const GRAVITY = 128
# Ground State Variable Speeds
const WALK_SPEED = 64
const RUN_SPEED = 128
const CRAWL_SPEED = 32
# Air State Variable Speeds
const JUMP_SPEED = -200
const HOVER_SPEED = -160
# Water State Variable Speeds
const SWIM_SPEED = 48
# Ladder State Variable Speeds
const CLIMB_SPEED = 64


var velocity = Vector2.ZERO
var speed

onready var _animation_player = $AnimatedSprite

var _current_state
var _can_crawl
var _can_jump
var _can_hover
var _can_climb


func getSpeed():
	return velocity

func getCurrentState():
	return _current_state
