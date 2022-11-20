extends Node

export var meteor_to_alien_ratio: int = 5

onready var _meteor = preload("res://scenes/game/levels/meteor/Meteor.tscn")
onready var _alien = preload("res://scenes/game/levels/alien/Alien.tscn")

onready var _meteorSpawnPoints: Array = $SpawnPoints/Top.get_children()
onready var _alienSpawnPoints: Array = $SpawnPoints/Sides.get_children()
onready var _hazardList = $Hazards

onready var playerShip: Vector2

func _on_SpawnInterval_timeout() -> void:
	var hazardType = randi()%meteor_to_alien_ratio
	if hazardType > 2:
		spawnMeteor()
	else:
		spawnAlien()


func spawnMeteor():
	var index = randi()%_meteorSpawnPoints.size() - 1
	var meteor = _meteor.instance()
	meteor.playerShip = playerShip
	_hazardList.add_child(meteor)
	meteor.position = _meteorSpawnPoints[index].position

func spawnAlien():
	var index = randi()%_alienSpawnPoints.size() - 1
	var alien = _alien.instance()
	_hazardList.add_child(alien)
	alien.position = _alienSpawnPoints[index].position
	if alien.position.x < 0:
		alien.moveRight()
	else:
		alien.moveLeft()
