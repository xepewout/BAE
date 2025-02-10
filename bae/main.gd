extends Node
@onready var anger: TextureProgressBar = $Anger
#GAMES
const SNAKE_GAME = preload("res://scenes/snake_game.tscn")
const FILE_SORT = preload("res://scenes/file_sort.tscn")
const BEER = preload("res://scenes/beer.tscn")
const CHICKEN_HUNT = preload("res://scenes/chicken_hunt.tscn")
const BRIEF = preload("res://brief.tscn")
const CHICKEN_SORT = preload("res://scenes/chicken_sort.tscn")
const SLAUGHTER = preload("res://scenes/slaughter.tscn")
const SLACK = preload("res://slack.tscn")
var brief = BRIEF.instantiate()
var slack = SLACK.instantiate()
var snake = SNAKE_GAME.instantiate()
var fileSort = FILE_SORT.instantiate()
var beer = BEER.instantiate()
var chickenHunt = CHICKEN_HUNT.instantiate()
var chickenSort = CHICKEN_SORT.instantiate()
var slaughter = SLAUGHTER.instantiate()


#VARIABLE STATES
var drunk = false
var electric = false
var buzzed = false
var day = 1
var passedGames = 0
var fileStart = false
var hidePress = true
var slackMessage = 0
#TARGETS
var chickensKilled = 0
var beersDrank = 0
var snakeTarget = 15
var filesTarget = 10
var slaughterTarget = 15
var chickenHuntTarget = 10
var chickenSortTarget = 10
var foodAte = 0
var filesSorted = 0
var chickensCaught = 0
var chickensMatched = 0

@onready var slaughter_button: Button = $SlaughterButton
@onready var game_timer: Timer = $GameTimer
@onready var chicken_hunt_button: Button = $ChickenHuntButton
@onready var chicken_sort_button: Button = $ChickenSortButton
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
@onready var time_label: Label = $TimeLabel
@onready var day_4_label: Label = $Day4Label
@onready var slack_button: Button = $SlackButton
@onready var slack_timer: Timer = $SlackTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(brief)
	add_child(slack)
	slack.visible = false
	brief.visible = true
	anger.value = 0
	snake.queue_free()
	fileSort.queue_free()
	beer.queue_free()
	chickenSort.queue_free()
	slaughter.queue_free()
	snake = null
	fileSort = null
	beer = null
	chickenHunt = null
	chickenSort = null
	slaughter = null
	_changeDays()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	beer_label.set_text("time to next beer \n" + str(beer_timer.get_time_left()).pad_decimals(1))
	time_label.set_text("TIME REMAINING: " + str(game_timer.get_time_left()).pad_decimals(1))
	if Input.is_action_just_pressed("tab"):
		_hide(!hidePress)
	if Input.is_action_just_pressed("enter"):
		if brief.visible:
			brief.visible = false
		if slack.visible:
			slack.visible = false
			slackMessage += 1
			slack_button.visible = false
			slack_timer.start(2)

#temp damage function for chicken_hunt
func _damage2():
	anger.value += 10

#damage function puts anger up
func _damage(game):
	print("hi")
	print(game)
	anger.value += 10
	if drunk:
		filesSorted -= randi_range(-4,4)
		foodAte -= randi_range(-4,4)
		chickensMatched -= randi_range(-4,4)
	elif electric:
		filesSorted += 1
		foodAte += 1
		chickensMatched -= 1
	else:
		filesSorted -= 1
		foodAte -= 1
		chickensMatched -= 2
		
	drunk = false
	electric = false
	if anger.value == 100:
		_gameOver()
	if game == "Snake" and snake: 
		snake.queue_free()
		snake = SNAKE_GAME.instantiate()
		add_child(snake)
	if game == "File Sort" and fileSort:
		fileSort.queue_free()
		fileSort = FILE_SORT.instantiate()
		add_child(fileSort)
	if game == "Chicken Sort" and chickenSort:
		chickenSort.queue_free()
		chickenSort = CHICKEN_SORT.instantiate()
		add_child(chickenSort)
	
#the beer timer
func _beerTime():
	get_tree().paused = true
	beer_timer.start(randi_range(5,20))
	if !beer:
		beer = BEER.instantiate()
		add_child(beer)
	else:
		beer.queue_free()
		beer = null

#add filesort to the game - first function to add
func _fileSortTime(toggle):
	#debug
	print(toggle)
	print(!fileSort)
	print(file_sort_button.visible)
	beer_timer.start(randi_range(5,20))
	if toggle and !fileSort and file_sort_button.visible == true:
		fileSort = FILE_SORT.instantiate()
		add_child(fileSort)
		if day > 1:
			_snakeTime(toggle)
		if day > 2:
			_chickenHuntTime(toggle)
		if day >3:
			_chickenSortTime(toggle)
		if day>4:
			_slaughterTime(toggle)
#add snake to the game
func _snakeTime(toggle):
	#debug
	if toggle and !snake and snake_button.visible == true:
		snake = SNAKE_GAME.instantiate()
		add_child(snake)
		if !fileSort:
			_fileSortTime(toggle)
			
#add chicken hunt to the game
func _chickenHuntTime(toggle):
	_hide(!toggle)
	if toggle and !chickenHunt and chicken_hunt_button.visible == true:
		chickenHunt = CHICKEN_HUNT.instantiate()
		add_child(chickenHunt)
		if !chickenSort:
			_chickenSortTime(toggle)
		if !slaughter:
			_slaughterTime(toggle)
		
#add chicken sort to the game
func _chickenSortTime(toggle):
	_hide(!toggle)
	if toggle and !chickenSort and chicken_sort_button.visible == true:
		chickenSort = CHICKEN_SORT.instantiate()
		add_child(chickenSort)
		if !chickenHunt:
			_chickenHuntTime(toggle)
#add slaughter to the game
func _slaughterTime(toggle):
	_hide(!toggle)
	if toggle and !slaughter and slaughter_button.visible == true:
		slaughter = SLAUGHTER.instantiate()
		add_child(slaughter)
		if !fileSort:
			_fileSortTime(toggle)
			
func _slackTime():
	slack_button.visible = true
#beer scene calls beer after checking target
func _beer():
	beer.queue_free()
	beer = null
	display_timer.start(1)
	get_tree().paused = false
	if electric:
		electric_pic.visible = true
		if fileSort:
			fileSort._electric()
		if snake:
			snake._electric()
		if chickenHunt:
			chickenHunt._electric()
	elif drunk:
		drunk_pic.visible = true
		if fileSort:
			fileSort._normal()
		if snake:
			snake._normal()
	else:
		if snake:
			snake._normal()
		if fileSort:
			fileSort._normal()
		print("buzzed")

func _slack():
	slack.visible = true
	if anger.value >= 10:
		anger.value -= 2
	if day>=3:
		game_timer.start(game_timer.time_left + 5)

func _hide(toggle):
	if chickenSort and chicken_sort_button.visible:
		chickenSort.visible = !toggle
		if !toggle:
			chickenSort.process_mode = PROCESS_MODE_INHERIT
		else: 
			chickenSort.process_mode = PROCESS_MODE_DISABLED
	if chickenHunt and chicken_hunt_button.visible:
		chickenHunt.visible = !toggle
		if !toggle:
			chickenHunt.process_mode = PROCESS_MODE_INHERIT
		else: 
			chickenHunt.process_mode = PROCESS_MODE_DISABLED
	if snake and snake_button.visible:
		snake.visible = toggle
		if toggle:
			snake.process_mode = PROCESS_MODE_INHERIT
		else:
			snake.process_mode = PROCESS_MODE_DISABLED
	if fileSort and file_sort_button.visible:
		fileSort.visible = toggle
		if toggle:
			fileSort.process_mode = PROCESS_MODE_INHERIT
		else:
			fileSort.process_mode = PROCESS_MODE_DISABLED
	hidePress = toggle
	
func _slaughterPass():
	chickensKilled = 0
	slaughter.visible = false
	slaughter_button.visible = false
	passedGames += 1
	slaughter.queue_free()
	slaughter = null
	if passedGames == day:
		_pass()

func _chickenSortPass():
	chickensMatched = 0
	chickenSort.visible = false
	chicken_sort_button.visible = false
	passedGames += 1
	chickenSort.queue_free()
	chickenSort = null
	if passedGames == day:
		_pass()

func _chickenHuntPass():
	chickensCaught = 0
	chickenHunt.visible = false
	chicken_hunt_button.visible = false
	passedGames += 1
	chickenHunt.queue_free()
	chickenHunt = null
	if passedGames == day:
		_pass()
	
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
	game_timer.stop()
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
	brief.visible = true
	victory.visible = false
	beer_timer.stop()
	slackMessage = 0
	if day >= 2:
		snake_button.visible = true
	if day >= 3:
		time_label.visible = true
		game_timer.start(120)
		chicken_hunt_button.visible = true
	if day >=4:
		chicken_sort_button.visible = true
	if day >=5:
		slaughter_button.visible = true
		
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
	if chickenSort:
		chickenSort.queue_free()
		chickenSort = null
	if slaughter:
		slaughter.queue_free()
		slaughter = null
	game_over.visible = true
	game_over_timer.start(1)
	
func _display():
	electric_pic.visible = false
	drunk_pic.visible = false
	
func _reload():
	get_tree().reload_current_scene()
