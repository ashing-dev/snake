extends Node
class_name SnakeGameContainer

@export var game: Game

func _ready() -> void:
	var field = Field.new(20, 20)
	game = GameManager.new_game(field)
	add_child(game)
	game.owner = self
	game.score_changed.connect(on_score_changed)

func on_score_changed() -> void:
	$ScoreValue.text = "%d" % game.score
