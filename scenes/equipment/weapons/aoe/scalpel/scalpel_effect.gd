extends Area2D

var base_stats: WeaponBaseStats
var player_ref: PlayerEntity


func start(_player_ref: PlayerEntity, _base_stats: WeaponBaseStats):
  base_stats = _base_stats
  player_ref = _player_ref
  print("started effect")
  activate()


func activate() -> void:
  $AnimatedSprite2D.show()
  $AnimatedSprite2D.play()
  # fencepost - Apply a hit onto any enemies currently within the space
  _attack()


func deactivate() -> void:
  $AnimatedSprite2D.hide()
  $AnimatedSprite2D.stop()


func _attack() -> void:
  for body in self.get_overlapping_bodies():
    if (body.has_method("hit")):
      body.hit(player_ref, base_stats, player_ref.position.angle_to_point(body.position))


func _on_animated_sprite_2d_frame_changed() -> void:
  # Also play an attack noise
  _attack()
