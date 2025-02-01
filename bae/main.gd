extends Node
@onready var anger: TextureProgressBar = $Anger
const SNAKE_GAME = preload("res://scenes/snake_game.tscn")
const FILE_SORT = preload("res://scenes/file_sort.tscn")
var snake = SNAKE_GAME.instantiate()
var fileSort = FILE_SORT.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anger.value = 25
	add_child(snake)
	add_child(fileSort)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _damage():
	anger.value += 10
	print(anger.value)
	if snake: 
		snake.queue_free()
		snake = SNAKE_GAME.instantiate()
		add_child(snake)
