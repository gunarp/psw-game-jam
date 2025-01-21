extends Node

# Can likely take advantage of duck typing and just remove this class...
class_name Weapon

var weapon_type : PackedScene
var player: PlayerEntity

var attack_power: float = 5
var cooldown: float = 0.5
var speed: float = 200

func initialize(_player: PlayerEntity, _weapon: PackedScene) -> void:
	self.player = _player
	self.weapon_type = _weapon
	$CooldownTimer.start(cooldown)

func update_cooldown(_cooldown: float) -> void:
	$CooldownTimer.stop()
	self.cooldown = _cooldown
	$CooldownTimer.start(cooldown)

func _on_cooldown_timer_timeout() -> void:
	var projectile = weapon_type.instantiate()
	
	# This is an antipattern - we are giving a child class a reference back to this class,
	# should refactor this out if we have time (it could cause crashes)
	projectile.start(self)
	projectile.scale = player.scale # Applies the scale of the player to the projectile
	get_tree().root.add_child(projectile)
