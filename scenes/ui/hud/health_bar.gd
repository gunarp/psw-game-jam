extends TextureProgressBar

@export var health: EntityHealth

func _ready() -> void:
	value = health.health

func _process(delta: float) -> void:
	value = health.health
