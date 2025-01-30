extends Node2D

@export var grid_size := 16

func _move_to_new_position():
	var new_position = Vector2(randi_range(0, 20) * grid_size, randi_range(0, 20) * grid_size)
	position = new_position
