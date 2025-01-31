extends Node

@onready var music_slider = $Panel/VBoxContainer/MusicSlider
@onready var sfx_slider = $Panel/VBoxContainer/SFXSlider
@onready var close_button = $CloseButton

func _ready():
	# Initialize sliders to current volume levels
	var music_bus_index = AudioServer.get_bus_index("Music")
	var sfx_bus_index = AudioServer.get_bus_index("Sounds")
	
	music_slider.value = AudioServer.get_bus_volume_db(music_bus_index)
	sfx_slider.value = AudioServer.get_bus_volume_db(sfx_bus_index)
	
	# Connect the slider value changes to functions
	music_slider.connect("value_changed", Callable(self, "_on_music_slider_changed"))
	sfx_slider.connect("value_changed", Callable(self, "_on_sfx_slider_changed"))
	
	# Connect close button
	close_button.connect("pressed", Callable(self, "_on_close_button_pressed"))

func _on_music_slider_value_changed(value: float):
	var music_bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(music_bus_index, value)
	print("Music Volume set to:", value)

func _on_sfx_slider_value_changed(value: float):
	var sfx_bus_index = AudioServer.get_bus_index("Sounds")
	AudioServer.set_bus_volume_db(sfx_bus_index, value)
	print("Sounds Volume set to:", value)

# Close button to hide the menu
func _on_close_button_pressed():
	queue_free()
