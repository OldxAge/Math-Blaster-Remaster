extends Area2D

export var x_speed: int = 0
export var y_speed: int = 32

func _physics_process(delta: float) -> void:
	position += Vector2(x_speed, y_speed) * delta

func _on_Meteor_body_entered(body: Player) -> void:
	visible = false
	print("destroyed")
