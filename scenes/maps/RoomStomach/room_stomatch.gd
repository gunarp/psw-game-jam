extends Node2D

class_name RoomStomach


func _ready() -> void:
  _set_walls_enabled(true)


func _on_key_pickup() -> void:
  _set_walls_enabled(false)
  print("waking up slimes!")
  for slime in $slimes.get_children():
    slime.show_enemy()
    slime.collision_layer = slime.default_layer
    slime.collision_mask = slime.default_mask


func _set_walls_enabled(is_enabled: bool) -> void:
  $Walls/Right.set_deferred("disabled", !is_enabled)
  $Walls/Left.set_deferred("disabled", !is_enabled)
  $Sprite2D.visible = is_enabled
