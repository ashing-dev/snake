extends Node2D
class_name Snake

const DIR_NORTH = Vector2( 0, -1)
const DIR_SOUTH = Vector2( 0,  1)
const DIR_WEST	= Vector2(-1,  0)
const DIR_EAST	= Vector2( 1,  0)

# Vector2 array of all the nodes comprising the snake, where snakeQueue[0] is always the head of the snake.
var snake_queue: Array[Vector2] = []

# Tracks the snake's movement direction. Input only influences the direction of movement. Movement itself happens
# during a game tick.
var travel_direction: Vector2 = DIR_NORTH
var snake_start_position: Vector2 = Vector2(5, 5)
var lengthen_snake: bool = false

var field: Field
var timer: Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	snake_queue.push_back(snake_start_position)
	update_global_position()
	update_rotation()
	timer.timeout.connect(_on_tick)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# The documentation seems to recommend using _process to capture input via the InputMap feature, vs
	# _unhandled_input which has more a bit more complication/nuance.
	# See https://docs.godotengine.org/en/stable/tutorials/inputs/inputevent.html

	if Input.is_action_just_pressed("move_north"):
		_update_travel_direction(DIR_NORTH)
	elif Input.is_action_just_pressed("move_south"):
		_update_travel_direction(DIR_SOUTH)
	elif Input.is_action_just_pressed("move_east"):
		_update_travel_direction(DIR_EAST)
	elif Input.is_action_just_pressed("move_west"):
		_update_travel_direction(DIR_WEST)

	update_global_position()
	update_rotation()

# Update the travel direction. If the new direction is an invalid option, the travel direction is not
# changed. Note that in this case, validity is internal to the snake, so that it can't reverse on itself.
func _update_travel_direction(dir: Vector2) -> void:
	match dir:
		DIR_NORTH:
			if travel_direction != DIR_SOUTH:
				travel_direction = DIR_NORTH
		DIR_SOUTH:
			if travel_direction != DIR_NORTH:
				travel_direction = DIR_SOUTH
		DIR_EAST:
			if travel_direction != DIR_WEST:
				travel_direction = DIR_EAST
		DIR_WEST:
			if travel_direction != DIR_EAST:
				travel_direction = DIR_WEST


func _on_tick() -> void:
	_move()
	_eat()


func _move() -> void:
	var old_location = snake_queue[0]
	if !lengthen_snake:
		snake_queue.pop_back()
	var new_location = old_location + travel_direction
	snake_queue.push_front(new_location)


func _eat() -> void:
	# Need a field reference first.
	# Which means we need a field.
	# Which we don't have.
	# Because I'm being slow.
	pass


func get_head_location() -> Vector2:
	return snake_queue[0]

func update_global_position() -> void:
	global_position = get_head_location() * Cell.CELL_WIDTH
	# The sprite is centered so we can rotate it easily, so we need to
	# handle the offset in positioning.
	global_position += Vector2(Cell.CELL_WIDTH/2.0, Cell.CELL_WIDTH/2.0)

func update_rotation() -> void:
	match travel_direction:
		DIR_NORTH:
			$Sprite2D.global_rotation = deg_to_rad(180.0)
		DIR_SOUTH:
			$Sprite2D.global_rotation = deg_to_rad(0.0)
		DIR_EAST:
			$Sprite2D.global_rotation = deg_to_rad(270.0)
		DIR_WEST:
			$Sprite2D.global_rotation = deg_to_rad(90.0)
