extends Node

@onready var tracks = {
  "main": load("res://resource/music/ontogenesis.ogg"),
  "heart": load("res://resource/music/cardialgia.ogg"),
  "stomach": load("res://resource/music/sphygmomanometer_2.ogg"),
  "lung": load("res://resource/music/cacophony_2.ogg"),
  "brain": load("res://resource/music/terminal.ogg"),
}

@onready var enemy_to_spawn = {
  "main": load("res://scenes/enemies/bat/Bat.tscn"),
  "heart": load("res://scenes/enemies/slime/GreenSlime.tscn"),
  "stomach": load("res://scenes/enemies/slime/BlueSlime.tscn"),
  "lung": load("res://scenes/enemies/skull/skull.tscn"),
  "brain": load("res://scenes/enemies/bat/Bat.tscn"),
}

var current_region: String
@onready var obtained_keys = {}
const num_keys_to_obtain = 4

func _on_player_player_died() -> void:
  print("Game Over :(")

func _on_region_entered(_area: Area2D, entered_region: String) -> void:
  print("entered ", entered_region)

  if (entered_region == current_region):
    return

  current_region = entered_region
  $AudioStreamPlayer.stream = tracks[current_region]
  $AudioStreamPlayer.play()

  $EnemyFactory.change_mob_spawned(enemy_to_spawn[current_region])

  # Add any region specific secret sauce here
  match entered_region:
    "brain":
      _set_door_state(true)


func _on_key_pickup(key_name: String) -> void:
  obtained_keys[key_name] = true
  if (obtained_keys.size() == num_keys_to_obtain):
    print("bust down that wall!")
    _set_door_state(false)


func _set_door_state(is_closed: bool) -> void:
  $Walls/Door.visible = is_closed
  $Walls/Door/CollisionShape2D.set_deferred("disabled", !is_closed)
