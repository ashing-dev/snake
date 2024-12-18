extends Node2D
class_name Game

var snake_scene = preload("res://scenes/snake.tscn")

var field: Field
var snake: Snake
var timer: Timer

var score: int = 0

signal game_over
signal score_changed

func _init(_field:Field, tick_interval: float = 1.0) -> void:
	field = _field
	timer = _new_timer(tick_interval)
	snake = _new_snake(field, timer)
	field.snake = snake
	field.set_random_food_cell()

	add_child(field)
	add_child(snake)
	add_child(timer)

	snake.snake_moved.connect(_check_collisions)

func _ready() -> void:
	global_position = Vector2(0, 0)

func _check_collisions() -> void:
	if _is_snake_touching_self() || _is_snake_touching_boundary():
		timer.stop()
		game_over.emit()
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://scenes/title.tscn")

	if _is_snake_touching_food():
		snake.lengthen_snake = true
		field.set_random_food_cell()
		score += 50
		score_changed.emit()

func _new_timer(tick_interval: float) -> Timer:
	var _timer = Timer.new()
	_timer.wait_time = tick_interval
	_timer.autostart = true

	return _timer

func _new_snake(_field: Field, _timer: Timer) -> Snake:
	var _snake = snake_scene.instantiate()
	_snake.field = _field
	_snake.timer = _timer
	_snake.snake_start_position = Vector2(8,8) # TODO: Randomize starting location

	return _snake

func _is_snake_touching_self() -> bool:
	var snake_loc = snake.get_head_location()
	for loc in snake.snake_queue.slice(1, len(snake.snake_queue)):
		if loc == snake_loc:
			return true

	return false

func _is_snake_touching_boundary() -> bool:
	var snake_loc = snake.get_head_location()

	for cell in field.cells:
		if !cell.is_boundary:
			continue
		if cell.location == snake_loc:
			return true

	return false

func _is_snake_touching_food() -> bool:
	return snake.get_head_location() == field.food_cell.location

