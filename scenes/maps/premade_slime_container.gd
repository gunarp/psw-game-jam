extends Node2D

@export var player_ref: PlayerEntity

func _ready() -> void:
  for slime in get_children():
    slime.initialize(player_ref, Vector2(1, 1))
    slime.hide_enemy()
    slime.collision_layer = 0