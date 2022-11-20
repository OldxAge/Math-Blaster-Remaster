extends Area2D

export var x_speed: int = 32
export var y_speed: int = 0

func _physics_process(delta: float) -> void:
	position += Vector2(x_speed, y_speed) * delta

func _on_Alien_body_entered(_body: Player) -> void:
	visible = false

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



func startTimer():
	$ShootTimer.start(1)
	$ShootTimer.one_shot = false

func _on_ShootTimer_timeout() -> void:
	BulletSpawner.releaseNewBullet($FirePoint.get_global_position(), 1)
	print("Alien Shooting")
	#shootLaser Shoot solid line all the way to the ground
	



