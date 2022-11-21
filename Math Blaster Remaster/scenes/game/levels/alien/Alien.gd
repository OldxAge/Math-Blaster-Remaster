extends Area2D

onready var hazardSpawner
var boundary = 280
var hazardType = 1
export var x_speed: int = 32
export var y_speed: int = 0

func _ready() -> void:
	$ShootTimer.start(1)
	$ShootTimer.one_shot = false

func _physics_process(delta: float) -> void:
	position += Vector2(x_speed, y_speed) * delta
	if position.x > 280:
		moveLeft()
	elif position.x < -280:
		moveRight()

func _on_Alien_body_entered(_body: Player) -> void:
	queue_free()

func _on_Alien_area_entered(area: Area2D) -> void:
	if area.hazardType != hazardType:
		queue_free()

func moveLeft():
	if x_speed < 0:
		return
	else:
		x_speed *= -1

func moveRight():
	if x_speed > 0:
		return
	else:
		x_speed *= -1


func _on_ShootTimer_timeout() -> void:
	BulletSpawner.spawnBullet($FirePoint.get_global_position(), hazardType)
	#shootLaser Shoot solid line all the way to the ground
