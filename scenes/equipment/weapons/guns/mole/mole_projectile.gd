extends CharacterBody2D

var base_stats: BaseStats
var player_ref: PlayerEntity

# weapon specific properties
var num_bounces_left: int

func start(_player_ref: PlayerEntity, _base_stats: BaseStats):
	base_stats = _base_stats
	player_ref = _player_ref
	rotation = player_ref.facing_direction.angle()
	position = player_ref.position
	velocity = Vector2(base_stats.speed, 0).rotated(rotation)
	num_bounces_left = base_stats.level
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit(base_stats.attack_power * player_ref.get_attack_multiplier())
		
		num_bounces_left -= 1
		if (num_bounces_left == 0):
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
