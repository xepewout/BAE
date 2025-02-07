extends RigidBody2D
@onready var main: Node = $"../../"

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Wall"):
		_free()
		
func _free():
	queue_free()
	
	
