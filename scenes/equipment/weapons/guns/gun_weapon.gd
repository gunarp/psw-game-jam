extends Node

# Can likely take advantage of duck typing and just remove this class...
class_name Weapon

var player_ref: PlayerEntity
var weapon_type : PackedScene

# Generic weapon properties
@onready var stats : BaseStats = BaseStats.new()

func initialize(_player_ref: PlayerEntity, _weapon: PackedScene) -> void:
	self.player_ref = _player_ref
	self.weapon_type = _weapon
	$CooldownTimer.start(stats.cooldown)

func update_cooldown(_cooldown: float) -> void:
	$CooldownTimer.stop()
	stats.cooldown = _cooldown
	$CooldownTimer.start(stats.cooldown)

func _on_cooldown_timer_timeout() -> void:
	var projectile = weapon_type.instantiate()
	projectile.start(player_ref, stats)
	projectile.scale = stats.scale
	get_tree().root.add_child(projectile)
