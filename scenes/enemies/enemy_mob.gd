extends RigidBody2D

class_name EnemyEntity

@onready var player : PlayerEntity = get_tree().get_first_node_in_group("player")

# TODO: Refactor into specialized damage class
var damagePerSecond : int = 10

var despawn_delay : float = 1.5

func custom_set_scale(sc: Vector2) -> void:
	self.apply_scale(sc)
	$AnimatedSprite2D.apply_scale(sc)
	$CollisionShape2D.apply_scale(sc)

func _ready() -> void:
	$Parameters/EntitySpeed.set_speed(randf_range(50.0, 75.0))
	$Parameters/EntityHealth.health = 10
	$Parameters/EntityHealth.max_health = 10
	self.lock_rotation = true
	

func _physics_process(delta: float) -> void:
	var direction = self.global_position.direction_to(player.global_position)
	self.linear_velocity = $Parameters/EntitySpeed.get_velocity(direction) 
	#move_and_slide()
	#newEnemy.linear_velocity = speed.rotated(direction.angle())
	
func hit(damage: float) -> void:
	$Parameters/EntityHealth.on_damaged(damage)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$DespawnDelayTimer.start(despawn_delay)

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$DespawnDelayTimer.stop()

func _on_despawn_delay_timer_timeout() -> void:
	queue_free()


func _on_entity_health_entity_health_depleted() -> void:
	queue_free()
