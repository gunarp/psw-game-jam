extends Node

class_name EntityExperience
var level: int
var current_experience: int
var total_experience: int
var exp_per_level: int = 50 # can be changed in the future

signal level_up_emit

func on_exp_gather(exp_gain : int):
	total_experience += exp_gain
	current_experience += exp_gain
	
	if (current_experience >= exp_per_level):
		current_experience -= exp_per_level
		level += 1
		emit_signal("level_up_emit")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = 0
	total_experience = 0
	current_experience = 0


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
