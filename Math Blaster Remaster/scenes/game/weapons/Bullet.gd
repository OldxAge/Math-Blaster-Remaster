extends Area2D

var x_speed: int = 0
var y_speed: int = 0
var hazardType = 0
onready var spriteColor = $Sprite
var bulletTopBoundary = -200
var bulletBotBoundary = 100

func _physics_process(delta: float) -> void:
	position.y += y_speed * delta
	if position.y >= bulletBotBoundary or position.y <= bulletTopBoundary:
		queue_free()


func _on_Bullet_body_entered(body: Node) -> void:
	print("blammo" + str(body.name))
	if body.hazardType != hazardType:
		queue_free()


func _on_Bullet_area_entered(_hazard: Area2D) -> void:
	if _hazard.hazardType != hazardType:
		queue_free()



func zeroOutBullet():
	y_speed = 0
	

func initiateBulletMovement(_bulletSpeed: int):
	y_speed = _bulletSpeed
