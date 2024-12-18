extends Node
class_name SnakeGameContainer

@export var game: Game

func _ready() -> void:
	var field = Field.new(40, 35)
	game = GameManager.new_game(field)
	add_child(game)
	game.owner = self
	game.score_changed.connect(on_score_changed)
	game.game_over.connect(on_game_over)

func on_score_changed() -> void:
	$ScoreValue.text = "%d" % game.score

func on_game_over() -> void:
	$Extra.text = "You died."
