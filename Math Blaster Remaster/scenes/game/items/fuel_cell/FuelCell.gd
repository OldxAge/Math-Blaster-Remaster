extends Area2D


export var shape: int = 0
export var color: int = 0
export var content: int = 0


func _on_FuelCell_body_entered(body: Player) -> void:
	visible = false
	var _item = Item.new()
	_item.addContent(shape, color, content)
	body.addFuelToInventory(_item)
