extends Node
class_name TestContainer

@export var game: Game

func _ready() -> void:
	var field = Field.new(35, 35)
	game = GameManager.new_game(field)
	add_child(game)
	game.owner = self
