extends Area2D
@export var speed = 400
@export var inMob = false
@export var tempChick = Area2D
@onready var main: Node = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("Move_Right"):
		velocity.x += 1
	if Input.is_action_pressed("Move_Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Move_Down"):
		velocity.y += 1
	if Input.is_action_pressed("Move_Up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	
	if Input.is_action_pressed("space") and inMob:
		tempChick._free()
		main.chickensCaught+=1
		if main.chickensCaught == main.chickenHuntTarget:
			main._chickenHuntPass()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("mob"):
		inMob = true
	tempChick = area
	

func _on_area_exited(_area: Area2D) -> void:
	inMob = false
	tempChick = null
