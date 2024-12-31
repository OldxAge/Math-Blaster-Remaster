extends Node2D


@onready var info = $InfoLayer
@onready var fuelUI = $Fuel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fuelUI.value = $Player.getFuelLevel()

func _process(_delta: float) -> void:
	info.setVelocity($Player.getSpeed())
	info.setState($Player.getCurrentState())


func _on_PlayerShip_ready(extra_arg_0: Vector2) -> void:
	$HazardSpawner.playerShip = $PlayerShip.position


func _on_player_update_hover_fuel_ui(currentFuelLevel):
	fuelUI.value = currentFuelLevel
