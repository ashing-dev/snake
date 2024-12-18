extends Node

func new_game(_field: Field) -> Game:
	var field = _field

	return Game.new(field, .25)
