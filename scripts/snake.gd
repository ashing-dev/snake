class_name Snake

extends Node

const DIR_NORTH = Vector2( 0, -1)
const DIR_SOUTH = Vector2( 0,  1)
const DIR_WEST	= Vector2(-1,  0)
const DIR_EAST	= Vector2( 1,  0)

# Vector2 array of all the nodes comprising the snake, where snakeQueue[0] is always the head of the snake.
var snakeQueue: Array = []

# Tracks the snake's movement direction. Input only influences the direction of movement. Movement itself happens
# during a game tick.
var travelDirection: Vector2

func _init():
	pass


# Update the travel direction. If the new direction is an invalid option, the travel direction is not
# changed. Note that in this case, validity is internal to the snake, so that it can't reverse on itself.
func update_travel_direction(dir: Vector2) -> void:
	print("updating travel direction", dir)
	match dir:
		DIR_NORTH:
			if travelDirection != DIR_SOUTH:
				travelDirection = DIR_NORTH
		DIR_SOUTH:
			if travelDirection != DIR_NORTH:
				travelDirection = DIR_SOUTH
		DIR_EAST:
			if travelDirection != DIR_WEST:
				travelDirection = DIR_EAST
		DIR_WEST:
			if travelDirection != DIR_EAST:
				travelDirection = DIR_WEST


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	# The documentation seems to recommend using _process to capture input via the InputMap feature, vs
	# _unhandled_input which has more a bit more complication/nuance.
	# See https://docs.godotengine.org/en/stable/tutorials/inputs/inputevent.html

	if Input.is_action_just_pressed("move_north"):
		update_travel_direction(DIR_NORTH)
	elif Input.is_action_just_pressed("move_south"):
		update_travel_direction(DIR_SOUTH)
	elif Input.is_action_just_pressed("move_east"):
		update_travel_direction(DIR_EAST)
	elif Input.is_action_just_pressed("move_west"):
		update_travel_direction(DIR_WEST)
