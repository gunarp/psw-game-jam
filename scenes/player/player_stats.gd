extends Node

class_name PlayerStats

@onready var damage_taken_multiplier: float = 1.0
@onready var attack_multiplier: float = 1.0
@onready var knockback_multiplier: float = 1.0
@onready var ragdoll_chance: float = 0
@onready var scale_multiplier: float = 1.0
@onready var duration_multiplier: float = 1.0
@onready var cooldown_multiplier: float = 1.0

signal stats_changed

func notify_stats_changed() -> void:
  stats_changed.emit()