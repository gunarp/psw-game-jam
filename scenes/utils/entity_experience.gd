extends Node

class_name EntityExperience
@onready var level: int = 0
@onready var current_experience: int
@onready var total_experience: int

@onready var exp_per_level = [50, 100, 100, 300, 300, 500, 500]
@onready var level_up_threshhold: int = 50

signal exp_level_up(level_up_threshhold: float)

func on_exp_gather(exp_gain: int):
  total_experience += exp_gain
  current_experience += exp_gain

  if (current_experience >= level_up_threshhold):
    current_experience = 0
    level += 1
    level_up_threshhold = exp_per_level[level] if level < exp_per_level.size() else exp_per_level[-1]
    exp_level_up.emit(level_up_threshhold)
