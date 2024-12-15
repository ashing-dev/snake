extends Node
class_name TestContainer

@export var game: Game

func _ready() -> void:
	var field = Field.new(10, 20)
	game = GameManager.new_game(field)
	add_child(game)
