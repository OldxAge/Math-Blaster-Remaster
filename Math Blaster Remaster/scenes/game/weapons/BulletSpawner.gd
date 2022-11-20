extends Node2D

onready var _bulletArray: Array = $Bullets.get_children()
onready var _holdingPoint: Position2D = $HoldingPosition
var _bulletIndex: int = 0

func releaseNewBullet(_firePoint: Vector2, _bulletDirection: int):
	var _newBullet = _bulletArray.pop_front()
	_newBullet.initiateBulletMovement(_bulletDirection)
	_newBullet.position = _firePoint
	_newBullet.visible = true


func handleSpentBullet(_spentBullet : Area2D):
	_spentBullet.visible = false
	_spentBullet.zeroOutBullet()
	_spentBullet.position = _holdingPoint.position
	_bulletArray.append(_spentBullet)
