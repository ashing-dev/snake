extends Area2D
class_name Cell

const CELL_WIDTH = 16

var location: Vector2
var is_boundary: bool

func _init(x: int, y: int, _is_boundary: bool):
	location = Vector2(x, y)
	is_boundary = _is_boundary


func _ready():
	set_position(location * CELL_WIDTH)
