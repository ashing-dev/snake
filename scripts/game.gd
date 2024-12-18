extends Node2D

class_name Game

var snake_scene = preload("res://scenes/snake.tscn")

var field: Field
var snake: Snake
var timer: Timer

var score: int = 0

func _init(_field:Field) -> void:
	field = _field
	timer = _new_timer()
	snake = _new_snake(field, timer)
	field.snake = snake

	add_child(field)
	add_child(snake)
	add_child(timer)

func _ready() -> void:
	global_position = Vector2(0, 0)

func _new_timer() -> Timer:
	var _timer = Timer.new()
	_timer.wait_time = 1.0
	_timer.autostart = true

	return _timer

func _new_snake(_field: Field, _timer: Timer) -> Snake:
	var _snake = snake_scene.instantiate()
	_snake.field = _field
	_snake.timer = _timer
	_snake.snake_start_position = Vector2(8,8) # TODO: Randomize starting location

	return _snake
