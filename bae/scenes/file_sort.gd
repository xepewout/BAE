extends Node2D
@onready var timer: Timer = $Buckets/Timer
@onready var buckets: Node2D = $Buckets
@onready var files: Label = $Files
@onready var main: Node = $"../"

func _electric():
	if buckets.timerTime > 1:
		buckets.timerTime = buckets.timerTime - 1

func _drunk():
	if buckets.timerTime > 1:
		buckets.timerTime = 5
		
func _process(delta: float) -> void:
	files.set_text("Files Sorted \n" + str(main.filesSorted) + "/10")
