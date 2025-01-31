extends Node2D

var base_stats: WeaponBaseStats
var player_ref: PlayerEntity

var rotation_speed: float = PI # rads / second
var inherent_scale: float = 1

func start(_player_ref: PlayerEntity, _base_stats: WeaponBaseStats):
  base_stats = _base_stats
  player_ref = _player_ref


func level_up():
  base_stats.attack_power += 1
  rotation_speed += PI / 4
  inherent_scale += 0.1
  _on_player_stats_changed()


func _on_player_stats_changed() -> void:
  var scalar = inherent_scale * player_ref.get_player_stats().scale_multiplier
  self.scale = Vector2(scalar, scalar)


func _process(delta: float) -> void:
  $Sprite2D.rotation += rotation_speed * delta


func _on_collision_shape_2d_body_entered(body:Node2D) -> void:
  if body.has_method("hit"):
    body.hit(player_ref, base_stats, player_ref.position.angle_to_point(body.position))
