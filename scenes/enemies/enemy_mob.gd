extends RigidBody2D

func custom_apply_scale(scale_mod: Vector2) -> void:
	self.apply_scale(scale_mod)
	$AnimatedSprite2D.apply_scale(scale_mod)
	$CollisionShape2D.apply_scale(scale_mod)

func _ready() -> void:
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
