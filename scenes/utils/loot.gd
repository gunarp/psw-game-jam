extends RigidBody2D

class_name Loot
var exp_val: int = 5

var thrust: float = 100
var overshootingThrustMultiplier:float = 5

# big ups to https://forum.godotengine.org/t/compensating-for-linear-velocity-in-a-homing-rigidbody2d/50508/4 for the homing code

var is_collected: bool = false
var player_ref: PlayerEntity

func _ready() -> void:
  self.sleeping = true


func _integrate_forces(_state: PhysicsDirectBodyState2D):
  if is_collected && is_instance_valid(player_ref):
    var targetRelativePos = transform.looking_at(player_ref.global_position).x.normalized()
    var directionDiff = (targetRelativePos.normalized() - linear_velocity.normalized())
    transform.x = targetRelativePos + directionDiff


func _physics_process(_delta: float):
  if is_collected && is_instance_valid(player_ref):
    #this will be -0.2 if heading straight towards target, and -2.2 if heading in the opposite direction
    var velocityOffset = linear_velocity.normalized().dot(transform.x.normalized()) -1.2
    #multiply velocityOffset by a negative number, so that the worse the current trajectory, the stronger the thrust
    var thrustModifier = velocityOffset*-overshootingThrustMultiplier
    #maximum possible thrust is 2.2*overshootingThrustMultiplier*thrust, but if our trajectory is correct, thrust will be 0.2* overshootingThrustMultiplier * thrust
    apply_central_force(transform.x * thrust * thrustModifier)


func init_pickup(_player: PlayerEntity):
  if not is_collected:
    self.player_ref = _player
    is_collected = true
    self.sleeping = false
    # self.linear_velocity = self.global_position.direction_to(player_ref.global_position) * 20


func on_collected() -> void:
  queue_free()