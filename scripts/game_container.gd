extends Node
class_name SnakeGameContainer

@export var game: Game

func _ready() -> void:
	var field = Field.new(40, 35)
	game = GameManager.new_game(field)
	$HighScoreValue.text = "%d" % GameManager.high_score
	add_child(game)
	game.owner = self
	game.score_changed.connect(on_score_changed)
	game.game_over.connect(on_game_over)


func on_score_changed() -> void:
	$ScoreValue.text = "%d" % game.score


func on_game_over() -> void:
	$Extra.text = "You died"
	$Death.play()
	GameManager.maybe_update_high_score(game.score)
	$HighScoreValue.text = "%d" % GameManager.high_score
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/title.tscn")
