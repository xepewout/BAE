extends Node2D
@onready var timer: Timer = $Buckets/Timer
@onready var buckets: Node2D = $Buckets

func _electric():
	if buckets.timerTime > 1:
		buckets.timerTime = buckets.timerTime - 1

func _drunk():
	if buckets.timerTime > 1:
		buckets.timerTime = 5
