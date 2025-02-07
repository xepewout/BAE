extends Node2D
@onready var chicken: Area2D = $Chicken
@onready var chicken_m: Area2D = $ChickenM
@onready var fox: Area2D = $Fox
@onready var fox_1: Area2D = $Fox1
<<<<<<< Updated upstream
@onready var main: Node2D = $".."
=======
>>>>>>> Stashed changes

var pictures = [chicken, chicken_m, fox, fox_1]
var totalPairs = 2
var pairsFound = 0
var flag = 0
var data = 0
var Tempchicken: Area2D
var debug = 0
var picturesDone = 0

func _click() -> bool:
	print(data)
	if data == 0:
		pairsFound += 1
		return true
		_checkIfDone()
	data = 0
	main._damage("Chicken Sort")
	return false

func _checkIfDone():
	if pairsFound == totalPairs:
		picturesDone+=1
		
func _setChicken(chicken: Area2D):
	Tempchicken = chicken
	print(Tempchicken)

func _shuffle():
	randomize()
	pictures.shuffle()
	pictures[0] = Vector2(1075,273)
	pictures[1] = Vector2(935, 273)
	pictures[2] = Vector2(935,415)
	pictures[3] = Vector2(1075,415)

	
