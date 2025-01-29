extends Node2D

var base_stats: WeaponBaseStats
var player_ref: PlayerEntity

var attacks_per_second: int = 8
var inherent_scale: float = 1.25
var offset: Vector2


func start(_player_ref: PlayerEntity, _base_stats: WeaponBaseStats):
  base_stats = _base_stats
  player_ref = _player_ref

  base_stats.knockback = 150.0

  offset.x = player_ref.get_shape().radius + $EffectLeft/HitBox.shape.radius
  $DurationTimer.one_shot = true
  $CooldownTimer.one_shot = true
  print("initialized weapon container")
  _deploy_children()


func _deploy_children():
  scale = base_stats.scale * player_ref.get_player_stats().scale_multiplier * inherent_scale

  $EffectLeft.position -= offset
  $EffectLeft/AnimatedSprite2D.speed_scale = attacks_per_second

  $EffectRight.position += offset
  $EffectRight/AnimatedSprite2D.speed_scale = attacks_per_second

  $EffectLeft.start(player_ref, base_stats)
  $EffectRight.start(player_ref, base_stats)
  $DurationTimer.start(base_stats.duration * player_ref.get_player_stats().duration_multiplier)


func _on_duration_timer_timeout() -> void:
  $EffectLeft.deactivate()
  $EffectRight.deactivate()
  $CooldownTimer.start(base_stats.duration * player_ref.get_player_stats().cooldown_multiplier)


func _on_cooldown_timer_timeout() -> void:
  $EffectLeft.activate()
  $EffectRight.activate()
  $DurationTimer.start(base_stats.duration * player_ref.get_player_stats().duration_multiplier)
