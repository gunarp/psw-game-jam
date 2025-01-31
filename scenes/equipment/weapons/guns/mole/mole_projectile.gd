extends CharacterBody2D

var base_stats: WeaponBaseStats
var player_ref: PlayerEntity

# weapon specific properties
var num_bounces_left: int
var last_object_collided_with: int = 0

func start(_player_ref: PlayerEntity, _base_stats: WeaponBaseStats):
  base_stats = _base_stats
  player_ref = _player_ref
  position = player_ref.position
  var projectile_direction = player_ref.prev_walking_direction.angle() + PI
  _update_velocity(Vector2(base_stats.speed, 0).rotated(projectile_direction))
  scale = base_stats.scale * player_ref.get_player_stats().scale_multiplier
  num_bounces_left = base_stats.level


func _update_velocity(vel: Vector2):
  self.velocity = vel
  match FacingHelpers.get_facing_direction(vel):
    FacingHelpers.FACING.LEFT:
      $AnimatedSprite2D.play("sideways")
      $AnimatedSprite2D.flip_h = true
    FacingHelpers.FACING.RIGHT:
      $AnimatedSprite2D.play("sideways")
      $AnimatedSprite2D.flip_h = false
    FacingHelpers.FACING.DOWN:
      $AnimatedSprite2D.play("down")
    _:
      $AnimatedSprite2D.play("default")


func _physics_process(delta):
  var collision = move_and_collide(velocity * delta)
  if collision:
    _update_velocity(velocity.bounce(collision.get_normal()))

    if collision.get_collider().has_method("hit"):
      if (last_object_collided_with != collision.get_collider_id()):
        collision.get_collider().hit(player_ref, base_stats, rotation)
      else:
        num_bounces_left += 1 # this is a silly way of ignoring this collision

    last_object_collided_with = collision.get_collider_id()
    num_bounces_left -= 1
    if (num_bounces_left == 0):
      queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
  queue_free()
