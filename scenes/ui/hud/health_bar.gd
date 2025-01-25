extends TextureProgressBar

@export var entity_health: EntityHealth

func _ready() -> void:
	value = entity_health.health

func _process(delta: float) -> void:
	value = entity_health.health
	
