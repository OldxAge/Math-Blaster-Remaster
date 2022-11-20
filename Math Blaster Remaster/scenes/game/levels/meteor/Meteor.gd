extends Area2D

onready var hazardSpawner
onready var playerShip: Vector2
var hazardType = 1

export var speed: int = 25


func _physics_process(delta: float) -> void:
	var motion = position.direction_to(playerShip) * speed * delta
	translate(motion)
	rotate(1 * delta)


func _on_Meteor_body_entered(_body: Player) -> void:
	queue_free()


func _on_Meteor_area_entered(area: Area2D) -> void:
	if area.hazardType != hazardType:
		queue_free()
