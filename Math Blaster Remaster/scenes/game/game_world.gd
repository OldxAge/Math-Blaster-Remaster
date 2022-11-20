extends Node2D


onready var info = $InfoLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	info.setVelocity($Player.getSpeed())
	info.setState($Player.getCurrentState())


func _on_PlayerShip_ready(extra_arg_0: Vector2) -> void:
	$HazardSpawner.playerShip = $PlayerShip.position
