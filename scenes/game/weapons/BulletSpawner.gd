extends Node2D


@onready var bullet_scene = preload("res://scenes/game/weapons/Bullet.tscn")
@export var _bullet_speed: int = 80


func spawnBullet(_firePoint: Vector2, _bulletOwner: int):
	var _newBullet = bullet_scene.instantiate()
	add_child(_newBullet)
	if _bulletOwner == 1:
		_newBullet.spriteColor.modulate = Color(.07,.75,.30,1)
	_newBullet.hazardType = _bulletOwner
	_newBullet.position = _firePoint
	_newBullet.initiateBulletMovement(_bullet_speed * _bulletOwner)
