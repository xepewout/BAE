extends Area2D
@onready var chicken_sort: Node2D = $".."
@onready var chicken: Area2D = $"."



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("mouse_left") and event.is_pressed() and not event.is_echo():
	#if Input.is_action_just_pressed("mouse_left"):
		chicken_sort.debug+=1
		chicken_sort.flag += 1
		chicken_sort.data -= 1
		chicken.visible = false
		if chicken_sort.flag == 2 or chicken_sort.flag == 0:
			chicken_sort.flag = 0
			if !chicken_sort._click():
				chicken.visible = true
				chicken_sort.Tempchicken.visible = true
				chicken_sort.Tempchicken = null
		else:
			chicken_sort._setChicken(chicken)
