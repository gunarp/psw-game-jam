extends RigidBody2D

class_name EnemyEntity

@onready var player: PlayerEntity = get_tree().get_first_node_in_group("player")

# Consider refactoring these into a dedicated enemy stats class
# stats class can probably be static (shared among all instances of this class)
# if we separate enemy types into individual classes as well
var damagePerSecond: int = 10
var damage_taken_multiplier: float = 1.0
var despawn_delay: float = 1.5

# not a required variable - but storing in this flag lets us
# skip over a length calculation each physics state cycle
var is_knockback_active: bool = false
# (units / s)
var knockback_applied: Vector2 = Vector2(0, 0)
# knockback deceleration factor
var knockback_decay: float = 0.5
var knockback_threshhold: float = 0.1

func custom_set_scale(sc: Vector2) -> void:
	self.apply_scale(sc)
	$AnimatedSprite2D.apply_scale(sc)
	$CollisionShape2D.apply_scale(sc)

func _ready() -> void:
	$Parameters/EntitySpeed.set_speed(randf_range(50.0, 75.0))
	$Parameters/EntityHealth.health = 10
	$Parameters/EntityHealth.max_health = 10
	self.lock_rotation = true
	$AnimatedSprite2D.play()


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if (not is_knockback_active):
		var direction = self.global_position.direction_to(player.global_position)
		state.linear_velocity = $Parameters/EntitySpeed.get_velocity(direction)


func _physics_process(delta: float) -> void:
	if (is_knockback_active):
		_set_knockback(knockback_applied * knockback_decay * delta)


func hit(_player_ref: PlayerEntity, attack_stats: BaseStats, attack_direction: float) -> void:
	# Could do an optional check against enemy defense stats here if we want
	var player_stats = player.get_player_stats()

	var damage : float = attack_stats.attack_power
	damage *= player_stats.attack_multiplier
	damage *= self.damage_taken_multiplier
	$Parameters/EntityHealth.on_damaged(damage)

	# Calculate knockback value
	var knockback: float = attack_stats.knockback
	knockback *= player_stats.knockback_multiplier
	_set_knockback(Vector2(1, 0).rotated(attack_direction) * knockback)


func _set_knockback(knockback: Vector2) -> void:
	knockback_applied = knockback
	if (knockback_applied.length() >= knockback_threshhold):
		is_knockback_active = true
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.modulate = Color(10, 10, 10, 10)
		self.apply_impulse(knockback_applied)
	else:
		is_knockback_active = false
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.modulate = Color.WHITE


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$DespawnDelayTimer.start(despawn_delay)


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$DespawnDelayTimer.stop()


func _on_despawn_delay_timer_timeout() -> void:
	queue_free()


func _on_entity_health_entity_health_depleted() -> void:
	queue_free()
