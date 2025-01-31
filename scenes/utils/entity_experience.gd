extends Node

class_name EntityExperience
var level: int
var current_experience: int
var total_experience: int
var exp_per_level: int = 50 # can be changed in the future

signal exp_level_up

func on_exp_gather(exp_gain : int):
  print("incrementing exp gain")
  total_experience += exp_gain
  current_experience += exp_gain
  
  # currently there is no changing the exp_per_level value
  # so the math below reflects that
  if (current_experience >= exp_per_level):
    current_experience -= exp_per_level
    level += 1
    exp_level_up.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  level = 0
  total_experience = 0
  current_experience = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
# CURRENTLY BEING USED TO DEBUG.
func _process(_delta: float) -> void:
  #on_exp_gather(10)
  #print("Exp. Gain: %d" % level)
  #print("Current Exp.: %d" % current_experience)
  #print("Total Exp.: %d" % total_experience)
  pass
