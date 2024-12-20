extends Node2D
class_name Snake

const DIR_NORTH = Vector2( 0, -1)
const DIR_SOUTH = Vector2( 0,  1)
const DIR_WEST	= Vector2(-1,  0)
const DIR_EAST	= Vector2( 1,  0)

const CHILD_NAME_TEMPLATE = "Body%d_%d"

var snake_body_scene = preload("res://scenes/snake_body.tscn")

# Vector2 array of all the nodes comprising the snake, where snakeQueue[0] is always the head of the snake.
var snake_queue: Array[Vector2] = []

# Tracks the snake's movement direction. Input only influences the direction of movement. Movement itself happens
# during a game tick.
var travel_direction: Vector2 = DIR_NORTH
var last_travel_direction: Vector2 = Vector2(0,0)
var snake_start_position: Vector2 = Vector2(5, 5)
var lengthen_snake: bool = false

var field: Field
var timer: Timer

signal snake_moved

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	snake_queue.push_back(snake_start_position)

	update_global_position()
	update_rotation()
	timer.timeout.connect(on_tick)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_north"):
		update_travel_direction(DIR_NORTH)
	elif Input.is_action_just_pressed("move_south"):
		update_travel_direction(DIR_SOUTH)
	elif Input.is_action_just_pressed("move_east"):
		update_travel_direction(DIR_EAST)
	elif Input.is_action_just_pressed("move_west"):
		update_travel_direction(DIR_WEST)

	update_global_position()
	update_rotation()


# Update the travel direction. If the new direction is an invalid option, the travel direction is not
# changed. Note that in this case, validity is internal to the snake, so that it can't reverse on itself.
func update_travel_direction(dir: Vector2) -> void:
	match dir:
		DIR_NORTH:
			if last_travel_direction != DIR_SOUTH:
				travel_direction = DIR_NORTH
		DIR_SOUTH:
			if last_travel_direction != DIR_NORTH:
				travel_direction = DIR_SOUTH
		DIR_EAST:
			if last_travel_direction != DIR_WEST:
				travel_direction = DIR_EAST
		DIR_WEST:
			if last_travel_direction != DIR_EAST:
				travel_direction = DIR_WEST


func on_tick() -> void:
	move()
	snake_moved.emit()


func move() -> void:
	var old_location = snake_queue[0]
	var new_location = old_location + travel_direction
	last_travel_direction = travel_direction
	if !lengthen_snake:
		# Remove from the data model
		var back = snake_queue.pop_back()

		# Remove the actual node
		var child = $BodyContainer.find_child(CHILD_NAME_TEMPLATE % [back.x, back.y])
		if child != null:
			$BodyContainer.remove_child(child)
			child.queue_free()
	
	if len(snake_queue) > 0:
		var new_child = snake_body_scene.instantiate()
		new_child.global_position = old_location * Cell.CELL_WIDTH
		new_child.name = CHILD_NAME_TEMPLATE % [old_location.x, old_location.y]
		$BodyContainer.add_child(new_child)
		new_child.owner = $BodyContainer

	snake_queue.push_front(new_location)

	lengthen_snake = false


func update_global_position() -> void:
	global_position = get_head_location() * Cell.CELL_WIDTH
	# The sprite is centered so we can rotate it easily, so we need to
	# handle the offset in positioning.
	global_position += Vector2(Cell.CELL_WIDTH/2.0, Cell.CELL_WIDTH/2.0)


func play_eat_sound() -> void:
	$EatSound.play()


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


func get_head_location() -> Vector2:
	return snake_queue[0]

