extends Node

class_name EntityHealth
var max_health: float
var health: float

# This will most likely always be 0, but if 
# there are any abilities with execute then this could help
var min_health: float = 0

signal entity_health_depleted

# This can also be used for healing
func on_damaged(damage: float):
	health = clamp(health - damage, min_health, max_health)
	
	if health == min_health:
		emit_signal("entity_health_depleted")
