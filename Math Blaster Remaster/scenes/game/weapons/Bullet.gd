extends Area2D

var x_speed: int = 0
var y_speed: int = 0
var bulletOwner

func _physics_process(delta: float) -> void:
	position.y += y_speed * delta


func _on_Bullet_body_entered(body: Node) -> void:
	print("blammo" + str(body.name))
	if body.hazardType != null:
		if body.hazardType != bulletOwner:
			queue_free()


func _on_Bullet_area_entered(_hazard: Area2D) -> void:
	print("Wowweeee + " + str(_hazard.name))
	if _hazard.hazardType != bulletOwner:
		queue_free()



func zeroOutBullet():
	y_speed = 0
	

func initiateBulletMovement(_bulletSpeed: int):
	y_speed = _bulletSpeed
