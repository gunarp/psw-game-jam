extends CharacterBody2D

class_name PlayerEntity

signal player_died

# TODO: make speed change with items
var speed: int = 100
var prev_walking_direction: Vector2
var walking_direction: Vector2
var facing_direction: Vector2

@onready var weapon_base: PackedScene = load("uid://d1vg0ederhg3f")

func _ready():
	_init_damage_subsystem()
	_init_attack_subsystem()
 	# TODO: Implement other subsystems - experience, attack, speed


func _physics_process(_delta: float) -> void:
	move_and_slide()


func _process(_delta: float) -> void:
	walking_direction = _get_movement_input()
	prev_walking_direction = walking_direction if walking_direction.length() > 0 else prev_walking_direction
	facing_direction = _get_direction_input()

	# TODO: implement dynamic speed system
	velocity = walking_direction * speed

	_render_character()


func get_shape():
	return $CollideBox.shape


#region Rendering helpers
func _render_character():
	match FacingHelpers.get_facing_direction(walking_direction):
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
#endregion


#region Input Helpers
func _get_movement_input() -> Vector2:
	# TODO: use joy_connection_changed event to add controller support
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")


func _get_direction_input() -> Vector2:
	# TODO: gamepad support
	return get_viewport().get_mouse_position() - (get_viewport_rect().size / 2)
#endregion

#region Damage Subsystem -- refactor out later
var healingPerSecond: float = 1.0
var damagePerSecond: float = 0
var damage_checks_per_second: int = 10
var extra_lives: int = 1

func _init_damage_subsystem() -> void:
	$Parameters/Health.max_health = 100
	$Parameters/Health.health = 100
	$DamageTimer.start(1.0 / damage_checks_per_second)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is EnemyEntity:
		damagePerSecond += body.stats.damage_per_second


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is EnemyEntity:
		damagePerSecond -= body.stats.damage_per_second


func _on_damage_timer_timeout() -> void:
	$Parameters/Health.on_damaged((damagePerSecond - healingPerSecond) / damage_checks_per_second)


func _on_health_entity_health_depleted() -> void:
	if (extra_lives > 0):
		# Play revive animation
		extra_lives -= 1
		$Parameters/Health.health = $Parameters/Health.max_health
	else:
		player_died.emit()
#endregion

#region Attack Subsystem -- refactorout later
func _init_attack_subsystem():
	# var starting_weapon = weapon_base.instantiate() as WeaponBase
	# add_child(starting_weapon)
	# starting_weapon.level_up()
	# starting_weapon.initialize(self, load("res://scenes/equipment/weapons/guns/mole/MoleProjectile.tscn"))

	var t = weapon_base.instantiate() as WeaponBase
	add_child(t)
	t.level_up()
	t.initialize(self, load("res://scenes/equipment/weapons/aoe/scalpel/ScalpelWeapon.tscn"))

	# var temp_weapon = weapon_base.instantiate() as WeaponBase
	# add_child(temp_weapon)
	# temp_weapon.level_up()
	# temp_weapon.initialize(self, load("res://scenes/equipment/weapons/guns/needle/NeedleProjectile.tscn"))


func get_attack_multiplier() -> float:
	return $Parameters/PlayerAttackStats.attack_multiplier

func get_player_stats() -> PlayerStats:
	return $Parameters/PlayerAttackStats
#endregion


func _on_music_zone_1_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
