extends Area2D
@onready var chicken_sort: Node2D = $".."
@onready var chicken: Area2D = $"."



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		chicken_sort.flag += 1
		chicken_sort.data += 1
		chicken.visible = false
		if chicken_sort.flag == 2 or chicken_sort.flag == 0:
			chicken_sort.flag = 0
			if !chicken_sort._click():
				chicken.visible = true
				chicken_sort.Tempchicken.visible = true
				chicken_sort.Tempchicken = null
				print("click was false")
		else:
			print("setChicken")
			chicken_sort._setChicken(chicken)
