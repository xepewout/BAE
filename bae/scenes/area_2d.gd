extends Area2D
@onready var chicken: RigidBody2D = $".."

func _free():
	chicken._free()
