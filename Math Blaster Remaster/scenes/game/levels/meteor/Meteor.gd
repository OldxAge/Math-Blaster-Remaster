extends Area2D

onready var hazardSpawner
onready var playerShip

export var speed: int = 25


func _physics_process(delta: float) -> void:
	position = position.move_toward(Vector2(0,0), speed * delta)
	rotate(1 * delta)


func _on_Meteor_body_entered(_body: Player) -> void:
	queue_free()


func _on_Meteor_area_entered(area: Area2D) -> void:
	queue_free()
