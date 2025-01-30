extends Area2D

@export var music_track: AudioStream  # Assign a different music file in the Inspector

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	print("Entered Body: ", body)
	print("Body Type: ", body.get_class())
	
	if body is PlayerEntity:
		print("PlayerEntity entered the area!")
		var audio_player = get_node("/root/Main/AudioStreamPlayer")

	if body.name == "Player":  # Ensure the player is entering
		var audio_player = get_node("/root/Main/AudioStreamPlayer")  
		if audio_player.stream != music_track:
			print("Changing music to ", music_track)
			audio_player.stream = music_track
			audio_player.play()
			print("Playing new music track.")
		else:
			print("Music is already playing.")
	else:
		print("AudioPlayer node not found!")
