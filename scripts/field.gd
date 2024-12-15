extends Node2D

class_name Field

var cells: Array

func _init(width: int, height: int):
	build_cells(width, height)
	for cell in cells:
		add_child(cell)

func _ready():
	pass

func build_cells(width, height):
	for y in height:
		for x in width:
			var is_boundary = false
			is_boundary = is_boundary || x == 0 
			is_boundary = is_boundary || y == 0
			is_boundary = is_boundary || x == width-1
			is_boundary = is_boundary || y == height-1

			# TODO: Pull boundary definitions from somewhere else so
			# we can make more interesting fields.
			cells.push_back(Cell.new(x, y, is_boundary))
