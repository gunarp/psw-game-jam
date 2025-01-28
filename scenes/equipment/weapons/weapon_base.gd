extends Node

## This class is honestly pretty sloppy and would benefit from
## a good refactor. However I am too lazy to do this at the moment
class_name WeaponBase

enum WEAPON_KIND{ projectile, aoe, melee, }

var player_ref: PlayerEntity
var weapon_recipe: PackedScene
var weapon_kind: WEAPON_KIND

# Generic weapon properties
@onready var stats: WeaponBaseStats = WeaponBaseStats.new()

func initialize(_player_ref: PlayerEntity, _weapon: PackedScene) -> void:
	self.player_ref = _player_ref
	self.weapon_recipe = _weapon

	var weapon_group = weapon_recipe.get_state().get_node_groups(0)
	if ("projectile" in weapon_group):
		weapon_kind = WEAPON_KIND.projectile
		$CooldownTimer.start(stats.cooldown)
	elif ("aoe" in weapon_group):
		weapon_kind = WEAPON_KIND.aoe
		add_child(weapon_recipe.instantiate())
	else:
		weapon_kind = WEAPON_KIND.melee


func update_cooldown(_cooldown: float) -> void:
	$CooldownTimer.stop()
	stats.cooldown = _cooldown
	$CooldownTimer.start(stats.cooldown)


func level_up() -> void:
	stats.level += 1


func _on_cooldown_timer_timeout() -> void:
	var projectile = weapon_recipe.instantiate()
	projectile.start(player_ref, stats)
	projectile.scale = stats.scale
	get_tree().root.add_child(projectile)

