extends Node2D
@onready var red_bucket: Node2D = $redBucket
@onready var green_bucket: Node2D = $greenBucket
@onready var blue_bucket: Node2D = $blueBucket
@onready var file: Sprite2D = $file/Sprite2D
@onready var timer: Timer = $Timer
@onready var buckets = [blue_bucket,green_bucket,red_bucket]
@onready var timer_bar: TextureProgressBar = $CanvasLayer/ColorRect/timerBar
@onready var main: Node = $"../.."
var addVector = Vector2 (0,0)
var addVectorY = Vector2 (0,0)
var fileNum = 0
var fileFlag = false
var timerTime = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !(main.fileStart):
		for i in buckets.size():
			buckets[i].position = Vector2 (700,394) + addVector
			addVector = addVector + Vector2(100,0)
		main.fileStart = true
	else:
		_shuffle()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_bar.value = timer.time_left * 20
	
func _shuffle():
	if fileFlag == true:
		main._damage()
	timer.start(timerTime)
	randomize()
	buckets.shuffle()
	addVector = Vector2 (0,0)
	addVectorY = Vector2 (0,0)
	for i in buckets.size():
		if main.drunk:
			buckets[i].position = Vector2 (700,394) + addVector + addVectorY
		else:	
			buckets[i].position = Vector2 (700,394) + addVector
		addVector = addVector + Vector2(100,0)
		addVectorY = addVectorY + Vector2 (0,100)
	fileNum = (randi() % 3)
	if buckets[fileNum] == blue_bucket:
		file.texture = preload("res://assests/sprites/fileSort/Files/blueFile.png")
	elif buckets[fileNum] == green_bucket:
		file.texture = preload("res://assests/sprites/fileSort/Files/greenFile.png")
	else:
		file.texture = preload("res://assests/sprites/fileSort/Files/redFile.png")
	fileFlag = true

func _input(event):
	if fileFlag:
		if !(event.is_action_pressed("one") or event.is_action_pressed("two") or event.is_action_pressed("three")):
			return
		else:	
			if !((fileNum == 0 and event.is_action_pressed("one")) or (fileNum == 1 and event.is_action_pressed("two")) or (fileNum == 2 and event.is_action_pressed("three"))):
				main.call_deferred("_damage")
				return
			if main.filesSorted == main.filesTarget:
				main._filesPass()
			else:
				fileFlag = false
				main.filesSorted += 1
				file.texture = preload("res://assests/sprites/fileSort/Files/passFile.png")
				timer.stop()
				timer.start(.5)
	
	
			
