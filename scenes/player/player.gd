extends CharacterBody2D

class_name PlayerEntity

signal player_died

# TODO: make speed change with items
var speed: int = 100
var walking_direction: Vector2
var facing_direction: Vector2

# !! This only works with the capsule shape currently used as a placeholder !!
@onready var health_bar_offset: Vector2 = -1 * (Vector2($PlayerHudElements/HealthBar.max_value / 2, $CollideBox.shape.height / 2) + Vector2(0, 10))

func _ready():
	_init_damage_subsystem()
	_init_attack_subsystem()
 	# TODO: Implement other subsystems - experience, attack, speed
	

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta: float) -> void:
	walking_direction = _get_movement_input()
	facing_direction = _get_direction_input()

	# TODO: implement dynamic speed system
	velocity = walking_direction * speed
	
	_render_character()

#region Rendering helpers
func _render_character():
	# There's probably a more efficient way to do this with vector math
	if (walking_direction.length() == 0):
		$AnimatedSprite2D.play("default")
	else:
		# Approach - rotate vector into a new coordinate system
		# and just use the x and y components to deduce which direction we are facing
		# avoids dealing with too many floating point operations + perciion
		var rotated_walking_direction = walking_direction.rotated(PI / 4)
		
		# This is a pretty verbose way of tackling this problem,
		# but I think it covers scenarios that would otherwise slip through the cracks
		# Special case - direction is a unit vector of our new coordinate system.
		if (rotated_walking_direction.x == 0):
			# Unit vector on y-axis
			if (rotated_walking_direction.y > 0):
				$AnimatedSprite2D.play("down")
			else:
				$AnimatedSprite2D.play("sideways")
				$AnimatedSprite2D.flip_h = true
		elif (rotated_walking_direction.y == 0):
			# Unit vector on x-axis
			if (rotated_walking_direction.x > 0):
				$AnimatedSprite2D.play("sideways")
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.play("down")
		else:
			# "General" case
			if (rotated_walking_direction.x > 0 and rotated_walking_direction.y > 0):
				$AnimatedSprite2D.play("sideways")
				$AnimatedSprite2D.flip_h = false
			elif (rotated_walking_direction.x < 0 and rotated_walking_direction.y > 0):
				$AnimatedSprite2D.play("down")
			elif (rotated_walking_direction.x < 0 and rotated_walking_direction.y < 0):
				$AnimatedSprite2D.play("sideways")
				$AnimatedSprite2D.flip_h = true
			elif (rotated_walking_direction.x > 0 and rotated_walking_direction.y < 0):
				$AnimatedSprite2D.play("default")

	# HealthBar and other PlayerHudElements should probably be decoupled from player
	# Don't want to think about that now though, so this will do
	#$PlayerHudElements.global_rotation = 0
	#$AnimatedSprite2D.flip_h = direction.x < 0
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
var healingPerSecond : float = 1.0
var damagePerSecond : float = 0
var damage_checks_per_second : int = 10
var extra_lives : int = 1

func _init_damage_subsystem() -> void:
	$Parameters/Health.max_health = 100
	$Parameters/Health.health = 100
	$PlayerHudElements/HealthBar.set_position(health_bar_offset)
	$DamageTimer.start(1.0 / damage_checks_per_second)
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is EnemyEntity:
		damagePerSecond += body.damagePerSecond


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is EnemyEntity:
		damagePerSecond -= body.damagePerSecond


func _on_damage_timer_timeout() -> void:
	$Parameters/Health.on_damaged((damagePerSecond - healingPerSecond) / damage_checks_per_second)


func _on_health_entity_health_depleted() -> void:
	if (extra_lives > 0):
		# Play revive animation
		extra_lives -= 1
		$Parameters/Health.health = $Parameters/Health.max_health
	else:
		emit_signal("player_died")
#endregion

#region Attack Subsystem -- refactorout later
# var list of weapons
#@onready var default_weapon = preload("res://scenes/equipment/weapons/needle/needle.tscn")
#var weapons : Array[Weapon] = []

func _init_attack_subsystem():
	print("intiialize attack subsystem")
	var starting_weapon = load("res://scenes/equipment/weapons/Weapon.tscn").instantiate() as Weapon
	add_child(starting_weapon)
	starting_weapon.initialize(self, load("res://scenes/equipment/weapons/needle/NeedleProjectile.tscn"))
	#add_child(weapon_template.instantiate())
	#weapons.push_back(weapon_template.instantiate())
	#for w: Weapon in weapons:
		#w.initialize(self, load("res://scenes/equipment/weapons/needle/NeedleProjectile.tscn"))
	#print("initilizaiton subroutie complete")
#endregion
