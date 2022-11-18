extends Area2D

export var x_speed: int = 32
export var y_speed: int = 48

func _physics_process(delta: float) -> void:
	position += Vector2(x_speed, y_speed) * delta
	rotate(1 * delta)

func _on_Meteor_body_entered(_body: Player) -> void:
	visible = false
