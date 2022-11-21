extends Area2D


export var y_speed: int = 48

export var shape: int = 0
export var color: int = 0
export var content: int = 0

#var groundSensor = $RayCast2D


func _physics_process(delta: float) -> void:
	position.y += y_speed * delta
	if $RayCast2D.is_colliding():
		y_speed = 0

func _on_FuelCell_body_entered(body: Player) -> void:
	visible = false
	var _item = Item.new()
	_item.addContent(shape, color, content)
	body.addFuelToInventory(_item)
	queue_free()
