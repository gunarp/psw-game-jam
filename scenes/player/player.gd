extends CharacterBody2D

# TODO: make speed change with items
var speed: int = 500

# !! This only works with the capsule shape currently used as a placeholder !!
@onready var health_bar_offset: Vector2 = Vector2($Parameters/Health/HealthBar.max_value / 2, $HurtBox.shape.height / 2) + Vector2(0, 5)

func _ready():
	# Initialize Parameters
	$Parameters/Health.health = 100

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta: float) -> void:
	# TODO: implement dynamic speed system
	velocity = _get_movement_input() * speed
	var direction = _get_direction_input()
	rotation = direction.angle()
	
	# TODO: use direction for aiming reticle rendering / functionality
	_render_character(direction)
	pass

#region Rendering helpers
func _render_character(direction: Vector2):
	if self.velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	#$AnimatedSprite2D.flip_h = direction.x < 0
	
	$Parameters/Health/HealthBar.set_position(position - health_bar_offset)
#endregion

#region Input Helpers
func _get_movement_input() -> Vector2:
	# TODO: use joy_connection_changed event to add controller support
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _get_direction_input():
	# TODO: gamepad support
	return get_viewport().get_mouse_position() - (get_viewport_rect().size / 2)
#endregion
