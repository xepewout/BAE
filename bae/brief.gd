extends Node2D
@onready var main: Node = $".."
@onready var label: Label = $Label




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if main.day == 2:
		label.text = ("Greetings worker. 
		Yesterday you did pretty good at sorting files. 
		So good, you are doing it again today. 
		I’m also putting you on a data calibration task. 
		My colleagues have mentioned it looks a lot 
		like an old game called “snake.” 
		It is not a snake. Take care!")
	if main.day == 3:
		label.text = ("Good morning worker! 
		We recently acquired a poultry company. 
		I got I.T. to hook up your computer to a drone. 
		We need you to capture wild chickens for breeding. 
		Just click them when you see them and the drone 
		will strike a tranquilizer into their necks. 
		Also, do some file sorting and data calibration while you are at it. 
		Get it done. ")
	if main.day == 4:
		label.text = ("Worker. 
		Good job yesterday. 
		I have just been informed that data calibration 
		was actually just “snake.” 
		The data analytics team has been terminated.
		 But, I still need you on file sorting. 
		There are plenty more chickens to catch as well. 
		We intend to breed our captured chickens. 
		That said, please match these chickens. 
		Each chicken has a unique lust, so match accordingly. 
")
