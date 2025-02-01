extends Node2D
@onready var timer: Timer = $Timer
@onready var beer_mug: TextureProgressBar = $BeerMug
var pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pressed:
		beer_mug.value = -(timer.time_left * 100) + 100 
		print("timer")
		print(timer.time_left)
	
func _input(event):
	
	if (event.is_action_pressed("space")):
		timer.start()
		pressed = true
	if (event.is_action_released("space")):
		pressed = false
		
		
			
