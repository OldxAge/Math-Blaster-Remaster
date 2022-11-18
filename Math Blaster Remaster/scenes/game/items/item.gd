extends Node
class_name Item

enum ItemShape {NONE, SQUARE, CIRCLE, TRIANGLE, STAR}
enum ItemColor {NONE, RED, BLUE, GREEN, YELLOW}

var shape: int = 0
var color: int = 0
var content: int = 0


func addContent(_shape:int, _color:int, _content:int):
	shape = _shape
	color = _color
	content = _content
