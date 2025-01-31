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

@onready var player: PlayerEntity = get_node("Player")

var current_region: String
@onready var obtained_keys = {}
const num_keys_to_obtain = 1

func _on_player_player_died() -> void:
  print("Game Over :(")

func _on_region_entered(_area: Area2D, entered_region: String) -> void:
  print("entered ", entered_region)

  if (entered_region == current_region):
    return

  current_region = entered_region
  $AudioStreamPlayer.stream = tracks[current_region]
  #TODO: PUT THIS BACK IN!!
  $AudioStreamPlayer.play()

  $EnemyFactory.change_mob_spawned(enemy_to_spawn[current_region])

  # Add any region specific secret sauce here
  match entered_region:
    #"stomach":
      #_set_door_state(false)
    "brain":
      _set_door_state(true)
      # spawn boss
      var boss = load("res://scenes/enemies/boss/Boss.tscn").instantiate()
      boss.initialize(player, Vector2(5.0, 5.0))
      boss.global_position = Vector2(50, -820)# set position
      get_tree().root.add_child(boss)

func _on_key_pickup(key_name: String) -> void:
  obtained_keys[key_name] = true
  if (obtained_keys.size() == num_keys_to_obtain):
    print("bust down that wall!")
    _set_door_state(false)


func _set_door_state(is_closed: bool) -> void:
  $Walls/Door.visible = is_closed
  $Walls/Door/CollisionShape2D.set_deferred("disabled", !is_closed)
