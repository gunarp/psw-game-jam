extends Node

@onready var tracks = {
	"main": load("res://resource/music/cacophony.ogg"),
	"heart": load("res://resource/music/cardialgia.ogg"),
	"stomach": load("res://resource/music/sphygmomanometer.ogg"),
	"lung": load("res://resource/music/cacophony.ogg"),
	"brain": load("res://resource/music/cacophony.ogg"),
}

var current_region: String


func _on_player_player_died() -> void:
	print("Game Over :(")


func _on_region_entered(_area: Area2D, entered_region: String) -> void:
	print("entered ", entered_region)

	if (entered_region == current_region):
		return

	current_region = entered_region
	$AudioStreamPlayer.stream = tracks[entered_region]
	$AudioStreamPlayer.play()
