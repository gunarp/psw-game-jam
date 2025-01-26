extends CharacterBody2D

var base_stats: BaseStats
var player_ref: PlayerEntity

# weapon specific properties
var num_pierce_left: int
#var enemies_hit: Dictionary = {}

func start(_player_ref: PlayerEntity, _base_stats: BaseStats):
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
			collider.hit(base_stats.attack_power * player_ref.get_attack_multiplier())
			add_collision_exception_with(collider)
			num_pierce_left -= 1
			if (num_pierce_left == 0):
				queue_free()
		elif collider.is_in_group("walls"):
			queue_free()
		

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
