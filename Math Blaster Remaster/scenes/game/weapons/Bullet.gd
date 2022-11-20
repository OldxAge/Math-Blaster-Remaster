extends Area2D

export var x_speed: int = 0
export var y_speed: int = 0
var _originalSpeed: int = 40

func _ready() -> void:
	_originalSpeed = y_speed

func _physics_process(delta: float) -> void:
	position.y += y_speed * delta


func _on_Bullet_body_entered(body: Node) -> void:
	print("blammo")
	zeroOutBullet()
	BulletSpawner.handleSpentBullet(self)


func _on_Bullet_area_entered(area: Area2D) -> void:
	print("Wowweeee")
	zeroOutBullet()
	BulletSpawner.handleSpentBullet(self)

func zeroOutBullet():
	y_speed = 0

func initiateBulletMovement(_bulletDirection):
	if _bulletDirection < 0:
		y_speed = _originalSpeed * _bulletDirection
	else:
		y_speed = _originalSpeed
