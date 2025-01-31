extends CanvasLayer

@export var player: PlayerEntity

@onready var health_bar_offset: Vector2 = -1 * (Vector2($HealthBar.max_value / 2, player.get_shape().height / 2) + Vector2(0, 40))
#@onready var health_bar_offset: Vector2 = Vector2(0, 0)
@onready var health_bar_scale: Vector2 = Vector2(0.4, 0.4)


func _ready() -> void:
	$HealthBar.set_position((get_viewport().get_visible_rect().size / 2) + (health_bar_offset * health_bar_scale))
	$HealthBar.scale = health_bar_scale

func _process(_delta):
	pass
