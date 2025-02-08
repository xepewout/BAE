extends Node2D
const CHICKEN = preload("res://scenes/chicken.tscn")
@onready var collision_shape_2d: CollisionShape2D = $Death/CollisionShape2D
var timePressed = 0
@onready var main: Node2D = $".."
@onready var count: Label = $Count


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_chickenSpawn()
	collision_shape_2d.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	count.set_text("Chickens killed \n" + str(main.chickensKilled) + "/15")
	if Input.is_action_pressed("x"):
		timePressed+=delta
		collision_shape_2d.disabled = false
		if timePressed > 1:
			collision_shape_2d.disabled = true
	if Input.is_action_just_released("x"):
		timePressed = 0
		collision_shape_2d.disabled = true

	
func _chickenSpawn():
	var chicken = CHICKEN.instantiate()
	var velocity = Vector2(randf_range(100.0, 120.0), 0.0)
	chicken.position = Vector2(40,62)
	chicken.linear_velocity = velocity
	add_child(chicken)


func _on_death_area_entered(area: Area2D) -> void:
	if area.name == "body":
		main.chickensKilled += 1
