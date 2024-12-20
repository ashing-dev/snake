extends Node

var high_score: int = 0

const INITIAL_TICK_INTERVAL = 0.25

func new_game(_field: Field) -> Game:
	var field = _field

	return Game.new(field, INITIAL_TICK_INTERVAL)

func maybe_update_high_score(new_score: int) -> void:
	if new_score > high_score:
		high_score = new_score
