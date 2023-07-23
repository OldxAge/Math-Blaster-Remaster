extends Area2D

var hazardType = -1
var health = 100

func _on_Ship_area_entered(area: Area2D) -> void:
	
	if area.hazardType != hazardType:
		print("Damaged. Health at " + str(health))
		health -= 10
	if health <= 0:
		visible = false


func _on_Ship_body_entered(body: Node) -> void:
	body.ship_clickable = true


func _on_Ship_body_exited(body: Node) -> void:
	body.ship_clickable = false

