extends Node

class_name EntitySpeed
# Store speed as a 1-d vector
var speed: Vector2

func set_speed(s: float):
	self.speed = Vector2(s, 0)

	
func get_velocity(direction: Vector2) -> Vector2:
	return speed.rotated(direction.angle())
