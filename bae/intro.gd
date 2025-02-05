extends Node2D
var labelNum = 1
@onready var label: Label = $Label
@onready var enter_label: Label = $EnterLabel
@onready var texture_rect: TextureRect = $TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		labelNum+=1
	if labelNum == 2:
		label.text = ("BEER")
	if labelNum == 3:
		label.text = ("ANGER")
	if labelNum == 4:
		label.text = ("ELECTRICITY")
	if labelNum == 5:
		label.text = ("POWER")
	if labelNum == 6:
		label.text = (" In order to meet quota, you will need to develop a mastery over \n these powerful forces. ")
	if labelNum == 7:
		label.visible = false
		texture_rect.visible = true
	if labelNum == 8:
		get_tree().change_scene_to_file("res://main.tscn")
