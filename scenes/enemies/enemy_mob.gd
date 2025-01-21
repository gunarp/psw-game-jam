extends RigidBody2D

class_name EnemyEntity

func custom_set_scale(sc: Vector2) -> void:
	self.apply_scale(sc)
	$AnimatedSprite2D.apply_scale(sc)
	$CollisionShape2D.apply_scale(sc)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
