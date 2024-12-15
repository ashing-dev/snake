extends Node2D

class_name Game

var field: Field
var snake: Snake

var score: int = 0

func _init(_field:Field) -> void:
	field = _field
	snake = Snake.new(Vector2(5, 5))
	add_child(field)
	add_child(snake)
