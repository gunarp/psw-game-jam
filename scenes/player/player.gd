extends CharacterBody2D

# TODO: Health bar
@export var health: int = 100

# TODO: make speed change with items
var speed: int = 500

var screen_size

func _get_input():
	# TODO: use joy_connection_changed event to add controller support
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	
func _physics_process(delta: float) -> void:
	_get_input()
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	# TODO: Add aiming reticle for directed projectiles
	var mouse_pos_from_center = get_viewport().get_mouse_position() - (get_viewport_rect().size / 2)
	$AnimatedSprite2D.flip_h = mouse_pos_from_center.x < 0
	
	move_and_slide()
