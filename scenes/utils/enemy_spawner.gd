extends Node

@export var spawn_timeout: int = 2
@export var mob_to_spawn: PackedScene
@export var mob_scale: Vector2 = Vector2(1.0, 1.0)
@export var camera: Camera2D

const margin_offset : Vector2 = Vector2(5, 5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnTimer.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(camera.get_canvas_transform().affine_inverse().basis_xform(camera.get_viewport_rect().size))
	#print(camera.get_canvas_transform().affine_inverse())
	pass


func _on_spawn_timer_timeout() -> void:
	var newEnemy = mob_to_spawn.instantiate() as EnemyEntity
	newEnemy.custom_set_scale(mob_scale)
	newEnemy.position = _get_random_spawn_position()
	add_sibling(newEnemy)
	pass


enum SPAWN_SIDE {LEFT, RIGHT, TOP, BOTTOM}
func _get_random_spawn_position() -> Vector2:
	var side_to_spawn_on = SPAWN_SIDE.values().pick_random()
	var camera_origin = camera.get_canvas_transform().affine_inverse().get_origin() + margin_offset
	var camera_extent = camera_origin + camera.get_viewport_rect().size - 2*margin_offset
	
	var spawn_pos = Vector2()
	match side_to_spawn_on:
		SPAWN_SIDE.LEFT: spawn_pos = Vector2(camera_origin.x, randf_range(camera_origin.y, camera_extent.y))
		SPAWN_SIDE.RIGHT: spawn_pos = Vector2(camera_extent.x, randf_range(camera_origin.y, camera_extent.y))
		SPAWN_SIDE.TOP: spawn_pos = Vector2(randf_range(camera_origin.x, camera_extent.x), camera_origin.y)
		SPAWN_SIDE.BOTTOM: spawn_pos = Vector2(randf_range(camera_origin.x, camera_extent.x), camera_extent.y)
	
	#print("spawning mob at: ", spawn_pos, " Player at: ", camera.get_screen_center_position())
	#print("Camera between these points: ", camera_origin, " ", camera_extent)
	return spawn_pos
