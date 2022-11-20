extends Node


onready var _meteors: Array = $Hazards/Meteors.get_children()
onready var _aliens: Array = $Hazards/Aliens.get_children()
onready var _meteorSpawnPoints: Array = $SpawnPoints/Top.get_children()
onready var _alienSpawnPoints: Array = $SpawnPoints/Sides.get_children()
onready var _holdingPoint: Position2D = $HoldingPoint
var _meteorIndex: int = 0
var _alienIndex: int = 0

func _ready() -> void:
	pass

func _on_SpawnInterval_timeout() -> void:
	
	spawnHazard()

func spawnHazard():
	var hazardType = randi()%5
	
	if hazardType > 2:
		var currentSpawn = randi()%_meteorSpawnPoints.size() - 1
		_meteors[_meteorIndex].position = _meteorSpawnPoints[currentSpawn].position
		_meteors[_meteorIndex].visible = true
		if(_meteorIndex >= _meteors.size() - 1):
			_meteorIndex = 0
		else:
			_meteorIndex += 1
	else:
		var currentSpawn = randi()%_alienSpawnPoints.size() - 1
		_aliens[_alienIndex].position = _alienSpawnPoints[currentSpawn].position
		if _aliens[_alienIndex].position.x < 0:
			_aliens[_alienIndex].moveRight()
		else:
			_aliens[_alienIndex].moveLeft()
		_aliens[_alienIndex].visible = true
		_aliens[_alienIndex].startTimer()
		if(_alienIndex >= _aliens.size() - 1):
			_alienIndex = 0
		else:
			_alienIndex += 1

func resetHazard(_hazard: Area2D):
	_hazard.position = _holdingPoint.position
	_hazard.visible = false
