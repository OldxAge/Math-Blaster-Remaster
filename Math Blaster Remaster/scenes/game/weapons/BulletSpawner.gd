extends Node2D


onready var bullet_scene = preload("res://scenes/game/weapons/Bullet.tscn")
export var _bullet_speed: int = 40


func spawnBullet(_firePoint: Vector2, _bulletDirection: int):
	var _newBullet = bullet_scene.instance()
	add_child(_newBullet)
	_newBullet.bulletOwner = _bulletDirection
	_newBullet.position = _firePoint
	_newBullet.initiateBulletMovement(_bullet_speed * _bulletDirection)
