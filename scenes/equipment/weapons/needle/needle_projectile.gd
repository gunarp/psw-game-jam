extends CharacterBody2D

var weapon_properties: Weapon

var num_bounces_left: int = 2

func start(_weapon_properties: Weapon):
	weapon_properties = _weapon_properties
	rotation = weapon_properties.player.facing_direction.angle()
	position = weapon_properties.player.position
	velocity = Vector2(weapon_properties.speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit(weapon_properties.attack_power)
		
		num_bounces_left -= 1
		if (num_bounces_left == 0):
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
