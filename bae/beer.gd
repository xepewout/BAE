extends Node2D
@onready var timer: Timer = $Timer
@onready var beer_mug: TextureProgressBar = $BeerMug
var pressed = false
var target = 50
var output = 0
@onready var main: Node = $".."
@onready var sprite_2d: Sprite2D = $BeerMug/Sprite2D
@onready var sprite_2d_2: Sprite2D = $BeerMug/Sprite2D2

func _ready() -> void:
	target = randi_range(0,425)
	sprite_2d.offset.y = 425 - (target-10)
	sprite_2d_2.offset.y = 425 - (target + 10)

func _process(_delta: float) -> void:
	if pressed:
		beer_mug.value = -(timer.time_left * 85) + 425 
		
func _input(event):
	if (event.is_action_pressed("space")):
		timer.start()
		pressed = true
		
	if (event.is_action_released("space")):
		output = beer_mug.value
		pressed = false
		_checkTarget()

func _checkTarget():
	
	if (absi(output - target) < 10):
		main.buzzed = true
		main.electric = false
		main.drunk = false
		main.beersDrank+=1
	elif ((output - target) < -10):
		main.electric = true
		main.drunk = false
		main.buzzed = false
	else:
		main.drunk = true
		main.electric = false
		main.buzzed = false
	if main.beersDrank >= 3:
		main.drunk = true
		main.electric = false
		main.buzzed = false
		main.beersDrank = 0
	main._beer()
		
			
