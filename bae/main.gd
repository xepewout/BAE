extends Node
@onready var anger: TextureProgressBar = $Anger
const SNAKE_GAME = preload("res://scenes/snake_game.tscn")
const FILE_SORT = preload("res://scenes/file_sort.tscn")
const BEER = preload("res://scenes/beer.tscn")
var snake = SNAKE_GAME.instantiate()
var fileSort = FILE_SORT.instantiate()
var beer = BEER.instantiate()
var drunk = false
var electric = false
var snakeTarget = 15
var filesTarget = 10
var foodAte = 0
var filesSorted = 0
var day = 1
var passedGames = 0
var fileStart = false
@onready var beer_timer: Timer = $BeerTimer
@onready var snake_button: Button = $SnakeButton
@onready var hide_button: Button = $HideButton
@onready var canvas_layer: TextureRect = $CanvasLayer
@onready var file_sort_button: Button = $FileSortButton
@onready var beer_label: Label = $BeerLabel
@onready var victory_timer: Timer = $VictoryTimer
@onready var victory: TextureRect = $Victory
@onready var game_over: TextureRect = $GameOver
@onready var game_over_timer: Timer = $GameOverTimer
@onready var electric_pic: TextureRect = $ElectricPic
@onready var drunk_pic: TextureRect = $DrunkPic
@onready var display_timer: Timer = $DisplayTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anger.value = 0
	beer_timer.start(randi_range(5,20))
	snake.queue_free()
	fileSort.queue_free()
	beer.queue_free()
	snake = null
	fileSort = null
	beer = null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	beer_label.set_text("time to next beer \n" + str(beer_timer.get_time_left()).pad_decimals(1))

func _damage():
	anger.value += 10
	drunk = false
	electric = false
	if anger.value == 100:
		_gameOver()
	if snake: 
		snake.queue_free()
		snake = SNAKE_GAME.instantiate()
		add_child(snake)
	if fileSort:
		fileSort.queue_free()
		fileSort = FILE_SORT.instantiate()
		add_child(fileSort)
		
func _beerTime():
	beer_timer.start(randi_range(5,20))
	if !beer:
		beer = BEER.instantiate()
		add_child(beer)
	else:
		beer.queue_free()
		beer = null
		_damage()

func _snakeTime(toggle):
	if toggle and !snake:
		snake = SNAKE_GAME.instantiate()
		add_child(snake)
		if !fileSort:
			_fileSortTime(toggle)
			
func _fileSortTime(toggle):
	if toggle and !fileSort:
		fileSort = FILE_SORT.instantiate()
		add_child(fileSort)
	if day > 1:
		_snakeTime(toggle)

func _beer():
	beer.queue_free()
	beer = null
	display_timer.start(1)
	if electric:
		electric_pic.visible = true
		if fileSort:
			fileSort._electric()
		if snake:
			snake._electric()
	if drunk:
		drunk_pic.visible = true
		if fileSort:
			fileSort._drunk()
		if snake:
			snake._drunk()
		
func _hide(toggle):
	if snake and snake_button.visible:
		snake.visible = toggle
	if fileSort and file_sort_button.visible:
		fileSort.visible = toggle

func _snakePass():
	foodAte = 0
	snake.visible = false
	snake_button.visible = false
	passedGames += 1
	snake.queue_free()
	snake = null
	if passedGames == day:
		_pass()

func _filesPass():
	filesSorted = 0
	fileSort.visible = false
	file_sort_button.visible = false
	fileSort.queue_free()
	fileSort = null
	passedGames += 1
	if passedGames == day:
		_pass()
	
func _pass():
	victory_timer.start(3)
		
	if beer:
		beer.queue_free()
	beer = null
	passedGames = 0
	day += 1
	victory.visible = true

func _changeDays():
	var background = "res://assests/backgrounds/days/day" + str(day) + ".png"
	canvas_layer.texture = load(background)
	file_sort_button.visible = true
	victory.visible = false
	if day >= 2:
		snake_button.visible = true
	print("victory")

func _gameOver():
	if snake:
		snake.queue_free()
		snake = null
	if beer:
		beer.queue_free()
		beer = null
	if fileSort:
		fileSort.queue_free()
		fileSort = null
	game_over.visible = true
	game_over_timer.start(1)
	
func _display():
	electric_pic.visible = false
	drunk_pic.visible = false
func _reload():
	get_tree().reload_current_scene()
