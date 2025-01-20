extends Node

@export var spawn_timeout: int = 2
@export var mob_to_spawn: PackedScene
@export var mob_scale: Vector2 = Vector2(1.0, 1.0)
@export var camera: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnTimer.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	print("spawn_timeout")
	var enemy_spawn = _get_random_position()
	var mob = mob_to_spawn.instantiate()

	#var direction = enemy_spawn - (get_viewport_rect().size / 2)
	var speed = Vector2(randf_range(-50.0, 50.0), 0)
	
	mob.position = enemy_spawn
	#mob.linear_velocity = speed.rotated(direction.angle())
	mob.custom_apply_scale(mob_scale)
	add_sibling(mob)


func _get_random_position() -> Vector2:
#	TODO: Change this to return a random position on one of the walls of the screen
	#var spawn_x = randf_range(get_viewport_rect().position.x, get_viewport_rect().end.x)
	#var spawn_y = randf_range(get_viewport_rect().position.y, get_viewport_rect().end.y)
	#return Vector2(spawn_x, spawn_y)
	return Vector2(0, 0)
