extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/VBoxContainer/PlayButton.pressed.connect(_on_play_button_pressed)
	$Panel/VBoxContainer/QuitButton.pressed.connect(_on_quit_button_pressed)

# Function to switch to the main game scene / play
func _on_play_button_pressed():
	print("Game Start!") # Debugging
	get_tree().change_scene_to_file("res://scenes/maps/main.tscn")
	
# Function to quit the game
func _on_quit_button_pressed():
	get_tree().quit()
	
