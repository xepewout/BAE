extends Node2D
@onready var BigChicken: Area2D = $Chicken
@onready var chicken_m: Area2D = $ChickenM
@onready var fox: Area2D = $Fox
@onready var fox_1: Area2D = $Fox1
@onready var main: Node2D = $".."


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
		print("pairs found", pairsFound)
		_checkIfDone()
		return true
	data = 0
	main._damage("Chicken Sort")
	return false

func _checkIfDone():
	if pairsFound == totalPairs:
		main.chickensMatched+=1
		print("chickens MAtched:")
		print(main.chickensMatched)
		if main.chickensMatched == main.chickenSortTarget:
			main._chickenSortPass()
		else:
			pairsFound = 0
			_shuffle()
		
func _setChicken(chicken: Area2D):
	Tempchicken = chicken

func _shuffle():
	var pictures = [BigChicken, chicken_m, fox, fox_1]
	randomize()
	pictures.shuffle()
	for i in pictures.size():
		pictures[i].visible = true
	pictures[0] = Vector2(1075,273)
	pictures[1] = Vector2(935, 273)
	pictures[2] = Vector2(935,415)
	pictures[3] = Vector2(1075,415)

	
