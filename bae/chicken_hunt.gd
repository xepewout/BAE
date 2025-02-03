extends Node2D
const CHICKEN = preload("res://scenes/chicken.tscn")
@onready var chicken: Label = $Chicken
@onready var main: Node = $"../"
@onready var crosshair: Area2D = $TextureRect/Crosshair

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	chicken.set_text("Chickens caught \n" + str(main.chickensCaught) + "/10")

func _electric():
	crosshair.speed = crosshair.speed * 1.25

func _on_mob_timer_timeout() -> void:
	print("spawning")
	var mob = CHICKEN.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(50.0, 70.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
