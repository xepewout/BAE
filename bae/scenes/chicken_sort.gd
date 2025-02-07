extends Node2D

var totalPairs = 2
var pairsFound = 0
var flag = 0
var data = 0
var Tempchicken: Area2D
var debug = 0

func _click() -> bool:
	print(data)
	if data == 0:
		print("data is 0")
		pairsFound += 1
		return true
		_checkIfDone()
	data = 0
	return false

func _checkIfDone():
	if pairsFound == totalPairs:
		print("done")
		
func _setChicken(chicken: Area2D):
	Tempchicken = chicken
	print(Tempchicken)

	
