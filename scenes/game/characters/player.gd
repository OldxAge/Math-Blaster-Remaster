class_name Player
extends CharacterBody2D


signal updateHoverFuelUI(currentFuelLevel)

const MVMT_ACCELERATION = 20.0
const HOVER_ACCELERATION = 2.0
const SWIM_ACCELERATION = 20.0
const AIR_RESISTANCE = 2.0
const WATER_RESISTANCE = 2.0
const GRAVITY = 128.0
# Ground State Variable Speeds
const WALK_SPEED = 64.0
const RUN_SPEED = 128.0
const CRAWL_SPEED = 32.0
# Air State Variable Speeds
const JUMP_SPEED = -200.0
const HOVER_SPEED = -160.0
const MAX_FUEL_LEVEL = 100.0
# This is the margin that hover fuel must be in order to begin allowing player to hover again.
# This prevents the player from staying in hover mode continuously as the fuel recharges in air
const HOVER_FUEL_MIN_MARGIN = 1
const FUEL_BURN_RATE = 1.0
const FUEL_RECHARGE_RATE_AIR = 0.05
const FUEL_RECHARGE_RATE_GROUND = 0.5
# Water State Variable Speeds
const SWIM_SPEED = 48.0
# Ladder State Variable Speeds
const CLIMB_SPEED = 64.0


var Cvelocity = Vector2.ZERO
# -------------------Remove after testing
var speed

@onready var _animation_player = $AnimatedSprite2D
@onready var _fire_point = $Firepoint

var _current_state
var _hover_fuel : float = MAX_FUEL_LEVEL
var _can_crawl
var _can_jump
var _can_hover
var _can_climb
var ship_clickable = false

var _playerInventory := []
var hazardType = -1

func addFuelToInventory(_item: Item):
	_playerInventory.append(_item)
	for n in _playerInventory.size():
		print(_playerInventory[n].shape, _playerInventory[n].color, _playerInventory[n].content)

# -------------------Remove after testing
func getSpeed():
	return velocity
# -------------------Remove after testing
func getCurrentState():
	return _current_state

func getFuelLevel():
	return _hover_fuel

func useHoverFuel():
	if (_hover_fuel > 0.0):
		_hover_fuel -= FUEL_BURN_RATE
		updateHoverFuelUI.emit(_hover_fuel)
	else:
		_can_hover = false

func rechargeHoverFuel(fuelRechargeRate := FUEL_RECHARGE_RATE_GROUND):
	if _hover_fuel > HOVER_FUEL_MIN_MARGIN:
		_can_hover = true
	_hover_fuel += fuelRechargeRate
	updateHoverFuelUI.emit(_hover_fuel)
