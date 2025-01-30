extends RigidBody2D

## It is assumed that the EnemyEntity has these child nodes
## - AnimatedSprite2D
## - CollisionShape2D
class_name EnemyEntity

@export_group("Enemy Stats")
@export var stats_speed: float = 50.0
@export var stats_health: float = 5

@export var stats_damage_per_second: float = 10.0
@export var stats_damage_taken_multiplier: float = 1.0

@export var stats_despawn_delay_s: float = 1.5

## min magnitude of knockback required for this unit to be knocked
@export var stats_knockback_resistance: float = 0.1
## how quickly knockback decays
@export var stats_knockback_decay: float = 0.5

## This should probalby be in another class
@export var stats_experience_dropped: int = 10

@export_group("Animation Properties")
@export var should_flip: bool = false

var despawn_timer = Timer.new()
var on_screen_notifier = VisibleOnScreenNotifier2D.new()

# not a required variable - but storing in this flag lets us
# skip over a length calculation each physics state cycle
var is_knockback_active: bool = false
var knockback_applied: Vector2 = Vector2(0, 0)

var player: PlayerEntity

func _ready() -> void:
  despawn_timer.one_shot = true
  despawn_timer.timeout.connect(_on_despawn_delay_timer_timeout)
  add_child(despawn_timer)
  on_screen_notifier.screen_entered.connect(_on_screen_enter)
  on_screen_notifier.screen_exited.connect(_on_screen_exit)
  add_child(on_screen_notifier)


# region public
## To be called by spawning object
func initialize(player_ref: PlayerEntity, spawn_scale: Vector2):
  player = player_ref

  _set_scale_custom(spawn_scale)
  _set_is_playing(true)
  self.lock_rotation = true

  self.collision_layer = 32
  self.collision_mask = 61


## _player_ref is unused... consider taking out if weapon classes are refactored again
func hit(_player_ref: PlayerEntity, attack_stats: WeaponBaseStats, attack_direction: float) -> void:
  # Could do an optional check against enemy defense stats here if we want
  var player_stats = player.get_player_stats()

  var damage: float = attack_stats.attack_power
  damage *= player_stats.attack_multiplier

  if (_apply_damage_is_dead(damage)):
    queue_free()
  else:
    var knockback: float = attack_stats.knockback
    knockback *= player_stats.knockback_multiplier
    _set_knockback(Vector2(1, 0).rotated(attack_direction) * knockback)


func get_dps() -> float:
  return stats_damage_per_second
#endregion


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  if (not is_knockback_active):
    var direction = self.global_position.direction_to(player.global_position)
    state.linear_velocity = direction * stats_speed
    if (self.should_flip):
      $AnimatedSprite2D.flip_h = (direction.x > 0)


func _physics_process(delta: float) -> void:
  if (is_knockback_active):
    _set_knockback(knockback_applied * stats_knockback_decay * delta)


## Applies damage to this enemy's health
## Returns true if the enemy is now dead
func _apply_damage_is_dead(damage: float) -> bool:
  stats_health -= (damage * stats_damage_taken_multiplier)
  return stats_health <= 0


func _set_knockback(knockback: Vector2) -> void:
  knockback_applied = knockback
  if (knockback_applied.length() >= stats_knockback_resistance):
    is_knockback_active = true
    self.apply_impulse(knockback_applied)
  else:
    is_knockback_active = false
  _set_is_knocked(is_knockback_active)


func _set_scale_custom(sc: Vector2) -> void:
  self.apply_scale(sc)
  $AnimatedSprite2D.apply_scale(sc)


func _set_is_knocked(knocked: bool) -> void:
  if knocked:
    $AnimatedSprite2D.stop()
    $AnimatedSprite2D.modulate = Color(10, 10, 10, 10)
  else:
    $AnimatedSprite2D.play()
    $AnimatedSprite2D.modulate = Color.WHITE


func _set_is_playing(playing: bool) -> void:
  if playing:
    $AnimatedSprite2D.play()
  else:
    $AnimatedSprite2D.stop()


func _on_screen_exit() -> void:
  despawn_timer.start(stats_despawn_delay_s)


func _on_screen_enter() -> void:
  despawn_timer.stop()


func _on_despawn_delay_timer_timeout() -> void:
  queue_free()
