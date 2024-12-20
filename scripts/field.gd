extends Node2D
class_name Field

const cell_scene = preload("res://scenes/cell.tscn")
const food_scene = preload("res://scenes/food.tscn")

var cells: Array
var snake: Snake
var food: Node2D
var food_cell: Cell
var field_size: Vector2


func _init(width: int, height: int):
	field_size = Vector2(width, height)
	build_cells(width, height)
	for cell in cells:
		add_child(cell)

	food = food_scene.instantiate()
	add_child(food)


func build_cells(width, height) -> void:
	for y in height:
		for x in width:

			# TODO: Pull boundary definitions from somewhere else so
			# we can make more interesting fields.
			var cell = cell_scene.instantiate()
			cell.is_boundary = determine_is_cell_boundary(x, y, width, height)
			cell.location = Vector2(x, y)
			cell.name = "Cell %d_%d" % [x, y]
			cells.push_back(cell)

func determine_is_cell_boundary(x: int, y: int, width: int, height: int) -> bool:
	var is_outer_wall = false
	is_outer_wall = is_outer_wall || x == 0
	is_outer_wall = is_outer_wall || y == 0
	is_outer_wall = is_outer_wall || x == width-1
	is_outer_wall = is_outer_wall || y == height-1

	return is_outer_wall


func set_random_food_cell() -> void:
	var candidates = [] 
	for cell in cells:
		if cell.is_boundary:
			continue
		var is_candidate = true
		for pos in snake.snake_queue:
			if cell.location == pos:
				is_candidate = false
				break
		if is_candidate:
			candidates.push_front(cell)
				
	food_cell = candidates[randi_range(0, len(candidates)-1)]
	food.global_position = food_cell.location * Cell.CELL_WIDTH

