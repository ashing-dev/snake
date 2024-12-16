extends Node2D

class_name Game

var snake_scene = preload("res://scenes/snake.tscn")
var field
var snake

var score: int = 0

func _init(_field:Field) -> void:
	field = _field
	snake = snake_scene.instantiate()
	snake.snake_start_position = Vector2(8,8) # TODO: Randomize starting location
	add_child(field)
	add_child(snake)

func _ready() -> void:
	global_position = Vector2(0, 0)
