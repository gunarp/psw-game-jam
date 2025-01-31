extends Control

@export var menu_music: AudioStream
@onready var play_button = $Panel/VBoxContainer/PlayButton
@onready var settings_button = $Panel/VBoxContainer/SettingsButton
@onready var quit_button = $Panel/VBoxContainer/QuitButton
@onready var sfx_audio_player = $ButtonSfx
var audio_player: AudioStreamPlayer

func _ready():
  # General button functionality then specific button
  play_button.pressed.connect(Callable(self, "_on_button_pressed"))
  play_button.pressed.connect(Callable(self, "_on_play_button_pressed"))

  settings_button.pressed.connect(Callable(self, "_on_button_pressed"))
  settings_button.pressed.connect(Callable(self, "_on_settings_button_pressed"))

  quit_button.pressed.connect(Callable(self, "_on_button_pressed"))
  quit_button.pressed.connect(Callable(self, "_on_quit_button_pressed"))

# Function to switch to the main game scene / play
func _on_play_button_pressed():
  print("Game Start!") # Debugging
  get_tree().change_scene_to_file("res://scenes/maps/main.tscn")

# Function to open settings menu scene
func _on_settings_button_pressed():
  var settings_scene = preload("res://scenes/ui/settingsmenu.tscn")
  var settings_instance = settings_scene.instantiate()
  get_tree().current_scene.add_child(settings_instance)

# Function to quit the game
func _on_quit_button_pressed():
  get_tree().quit()

# Common function for all button clicks
func _on_button_pressed():
  sfx_audio_player.play()

  audio_player = $AudioStreamPlayer
  audio_player.stream = menu_music
  audio_player.play()
