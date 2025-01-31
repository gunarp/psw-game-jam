extends Node

var experience = 0 # Current experience
var level = 1 
var experience_to_level = 100
var experience_per_enemy = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_experience(amount: int):
	experience += amount
	check_level_up()
	
func check_level_up():
	if experience >= experience_to_level:
		level_up()
		
func level_up():
	experience -= experience_to_level # Subtract xp used for lvl up
	level +=  1 # Increase the level
	experience_to_level = int(experience_to_level*1.5) # Increase required xp for next lvl up
	print("Leveled up! Current level: ", level)
