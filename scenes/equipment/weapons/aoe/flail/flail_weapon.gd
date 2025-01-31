extends Node2D

var base_stats: WeaponBaseStats
var player_ref: PlayerEntity

var rotation_speed: float = PI # rads / second
var inherent_scale: float = 1

func start(_player_ref: PlayerEntity, _base_stats: WeaponBaseStats):
  base_stats = _base_stats
  player_ref = _player_ref


func _process(delta: float) -> void:
  $Sprite2D.rotation += rotation_speed * delta


func _on_collision_shape_2d_body_entered(body:Node2D) -> void:
  if body.has_method("hit"):
    body.hit(player_ref, base_stats, player_ref.position.angle_to_point(body.position))
