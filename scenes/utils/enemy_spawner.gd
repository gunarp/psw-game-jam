extends Node

enum SPAWN_SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export var spawn_timeout: float = 0.25
@export var mob_to_spawn: PackedScene # packed EnemyEntity
@export var mob_scale: Vector2 = Vector2(1.0, 1.0)
@export var camera: Camera2D

@onready var player: PlayerEntity = get_tree().get_first_node_in_group("player")
@onready var space_state = player.get_world_2d().direct_space_state

const margin_offset: Vector2 = Vector2(5, 5)

func _ready() -> void:
	$SpawnTimer.start(spawn_timeout)


func change_mob_spawned(new_enemy: PackedScene) -> void:
	mob_to_spawn = new_enemy


func _on_spawn_timer_timeout() -> void:
	var newEnemy = mob_to_spawn.instantiate() as EnemyEntity
	newEnemy.initialize(player, mob_scale)
	newEnemy.global_position = _get_random_spawn_position()
	get_tree().root.add_child(newEnemy)


func _get_random_spawn_position() -> Vector2:
	var camera_origin = camera.get_canvas_transform().affine_inverse().get_origin() + margin_offset
	var camera_extent = camera_origin + camera.get_viewport_rect().size - 2 * margin_offset

	var spawn_pos = Vector2()
	
	while (true):
		var side_to_spawn_on = SPAWN_SIDE.values().pick_random()
		match side_to_spawn_on:
			SPAWN_SIDE.LEFT: spawn_pos = Vector2(camera_origin.x, randf_range(camera_origin.y, camera_extent.y))
			SPAWN_SIDE.RIGHT: spawn_pos = Vector2(camera_extent.x, randf_range(camera_origin.y, camera_extent.y))
			SPAWN_SIDE.TOP: spawn_pos = Vector2(randf_range(camera_origin.x, camera_extent.x), camera_origin.y)
			SPAWN_SIDE.BOTTOM: spawn_pos = Vector2(randf_range(camera_origin.x, camera_extent.x), camera_extent.y)

		# Now query for if this generated point would intersect a wall
		var query = PhysicsRayQueryParameters2D.create(spawn_pos, player.global_position)
		query.collision_mask = 0x0001
		query.hit_from_inside = true
		if (space_state.intersect_ray(query).size() == 0):
			break

	return spawn_pos
