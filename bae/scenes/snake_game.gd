extends Node2D
@onready var timer: Timer = $ColorRect/Snake/Timer

func _electric():
	timer.wait_time = timer.wait_time  * .5
	
func _drunk():
	timer.wait_time = .1
