extends Node2D
@onready var BigChicken: Area2D = $Chicken
@onready var chicken_m: Area2D = $ChickenM
@onready var fox: Area2D = $Fox
@onready var fox_1: Area2D = $Fox1
@onready var main: Node2D = $".."
@onready var chickens: Label = $Chickens


var totalPairs = 2
var pairsFound = 0
var flag = 0
var data = 0
var Tempchicken: Area2D
var debug = 0
var picturesDone = 0

func _process(_delta: float) -> void:
	chickens.set_text("Chickens sorted \n" + str(main.chickensMatched) + "/10")

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
	pictures[0].position = Vector2(870,218)
	pictures[1].position = Vector2(730, 218)
	pictures[2].position = Vector2(730,360)
	pictures[3].position = Vector2(870,360)
	for i in pictures.size():
		pictures[i].visible = true
	
