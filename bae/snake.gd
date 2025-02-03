extends Node2D

var direction := Vector2.RIGHT
var segment_positions := []  # Stores positions of body segments
var segments := []  # List of segment nodes

@onready var main: Node = $"../../.."
@export var grid_size := 16
@onready var timer: Timer = $Timer

func _ready() -> void:
	$Timer.timeout.connect(_move)

func _input(event):
	if event is InputEventKey and event.pressed:
		if main.drunk:
			match event.keycode:
				KEY_DOWN: direction = Vector2.UP if direction != Vector2.DOWN else direction
				KEY_LEFT: direction = Vector2.DOWN if direction != Vector2.UP else direction
				KEY_RIGHT: direction = Vector2.LEFT if direction != Vector2.RIGHT else direction
				KEY_UP: direction = Vector2.RIGHT if direction != Vector2.LEFT else direction
		else:
			match event.keycode:
				KEY_UP: direction = Vector2.UP if direction != Vector2.DOWN else direction
				KEY_DOWN: direction = Vector2.DOWN if direction != Vector2.UP else direction
				KEY_LEFT: direction = Vector2.LEFT if direction != Vector2.RIGHT else direction
				KEY_RIGHT: direction = Vector2.RIGHT if direction != Vector2.LEFT else direction

func _move():
	if main.snake.visible:
		# Calculate the new position for the head
		var new_position = position + direction * grid_size

		# Check for self-collision BEFORE updating the position
		if new_position in segment_positions:
			main._damage()
			

		# Store the old head position to shift the body properly
		segment_positions.insert(0, position)  # Store head's current position
		position = new_position  # Move the head to the new position

		# Move each segment to the position of the previous one
		for i in range(segments.size() - 1):
			segments[i].visible = true
			segments[i].position = segment_positions[i + 1]  # Shift segment
			segment_positions = segment_positions.slice(0, segments.size())  # Keep size in sync
		
		if segments.size() > 0:
			segment_positions = segment_positions.slice(0, segments.size())
	
func grow():

	# Create a new segment
	var segment = Sprite2D.new()
	segment.texture = preload("res://assests/sprites/snake/snake.png")
	
	# Place new segment at the last position in segment_positions
	var last_position = segment_positions[-1] if segment_positions else position
	segment.position = last_position
	segment.visible = false
	# Add segment to the parent and update tracking lists
	get_parent().add_child(segment)
	segments.append(segment)
	segment_positions.append(last_position)  # Keep segment_positions updated
	
func _on_area_entered(area):
	if area.is_in_group("Food"):
		grow()
		main.foodAte+=1
		area._move_to_new_position()
		if main.foodAte == main.snakeTarget:
			main._snakePass()
	elif area.is_in_group("Wall"):
		main.call_deferred("_damage")
	
