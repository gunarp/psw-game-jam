extends Node

class_name EntityHealth
var max_health: int
var health: int

# This will most likely always be 0, but if 
# there are any abilities with execute then this could help
var min_health: int = 0

# This can also be used for healing
func on_damaged(damage: int):
	health = clamp(health - damage, min_health, max_health)
	
	if health == min_health:
		# TODO: emit death event if health reaches threshold
		pass
