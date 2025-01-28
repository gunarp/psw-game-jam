extends CharacterBody2D

var base_stats: WeaponBaseStats
var player_ref: PlayerEntity

# weapon specific properties
var num_pierce_left: int

func start(_player_ref: PlayerEntity, _base_stats: WeaponBaseStats):
	base_stats = _base_stats
	player_ref = _player_ref
	rotation = player_ref.facing_direction.angle()
	position = player_ref.position
	velocity = Vector2(base_stats.speed, 0).rotated(rotation)
	num_pierce_left = base_stats.level


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("hit"):
			process_hit_enemy(collider)
		elif collider.is_in_group("walls"):
			queue_free()


func process_hit_enemy(enemy: Object):
	enemy.hit(player_ref, base_stats, rotation)
	add_collision_exception_with(enemy)
	num_pierce_left -= 1
	if (num_pierce_left == 0):
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
