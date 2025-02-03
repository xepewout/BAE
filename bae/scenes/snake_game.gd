extends Node2D
@onready var timer: Timer = $ColorRect/Snake/Timer
@onready var food: Label = $Food
@onready var main: Node = $"../"

func _electric():
	timer.wait_time = timer.wait_time  * .5
	
func _drunk():
	timer.wait_time = .1

func _process(delta: float) -> void:
	food.set_text("Food Ate \n" + str(main.foodAte) + "/15")
