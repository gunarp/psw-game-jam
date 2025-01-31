extends RigidBody2D

class_name HeartPiece

@export var spot: String

var is_placed: bool
var locked_position: Vector2


func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
  if is_placed:
    self.position = locked_position
    self.freeze = true
    self.sleeping = true


func lock_position(dest: Vector2) -> void:
  is_placed = true
  locked_position = dest
