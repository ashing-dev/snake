extends Node2D 
class_name Cell

const CELL_WIDTH = 16

var location: Vector2
var is_boundary: bool


func _ready():
	if is_boundary:
		var texture = load("res://textures/boundary_cell.tres")
		$Sprite2D.texture = texture

	global_position = location * CELL_WIDTH
