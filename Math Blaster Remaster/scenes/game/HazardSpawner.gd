extends Node


onready var _meteors: Array = $Hazards/Meteors.get_children()
onready var _aliens: Array = $Hazards/Aliens.get_children()
onready var _spawnPoints: Array = $SpawnPoints.get_children()
onready var _holdingPoint: Position2D = $HoldingPoint
var _meteorIndex: int = 0
var _alienIndex: int = 0

func _ready() -> void:
	pass

func _on_SpawnInterval_timeout() -> void:
	
	spawnHazard()

func spawnHazard():
	var hazardType = randi()%5
	var currentSpawn = randi()%_spawnPoints.size() - 1
	if hazardType > 2:
		_meteors[_meteorIndex].position = _spawnPoints[currentSpawn].position
		_meteors[_meteorIndex].visible = true
		if(_meteorIndex >= _meteors.size() - 1):
			_meteorIndex = 0
		else:
			_meteorIndex += 1
		print("Metoer Spawn at " + str(_meteors[_meteorIndex].position))
	else:
		_aliens[_alienIndex].position = _spawnPoints[currentSpawn].position
		_aliens[_alienIndex].visible = true
		if(_alienIndex >= _aliens.size() - 1):
			_alienIndex = 0
		else:
			_alienIndex += 1
		print("Alien Spawn")

func resetHazard(_hazard: Area2D):
	_hazard.position = _holdingPoint.position
	_hazard.visible = false
