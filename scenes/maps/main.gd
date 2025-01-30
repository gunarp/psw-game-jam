extends Node

@onready var tracks = {
	"main": load("res://resource/music/cacophony.ogg"),
	"heart": load("res://resource/music/cardialgia.ogg"),
	"stomach": load("res://resource/music/sphygmomanometer.ogg"),
	"lung": load("res://resource/music/cacophony.ogg"),
	"brain": load("res://resource/music/cacophony.ogg"),
}

@onready var enemy_to_spawn = {
	"main": load("res://scenes/enemies/bat/Bat.tscn"),
	"heart": load("res://scenes/enemies/slime/GreenSlime.tscn"),
	"stomach": load("res://scenes/enemies/slime/BlueSlime.tscn"),
	"lung": load("res://scenes/enemies/skull/skull.tscn"),
	"brain": load("res://scenes/enemies/bat/Bat.tscn"),
}

var current_region: String


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
