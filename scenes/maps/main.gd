extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print("target: ", $Camera2D.get_target_position(), " center: ", $Camera2D.position)
	#print($Camera2D.custom_viewport)
	pass


func _on_player_player_died() -> void:
	print("Game Over :(")


func _on_music_zone_1_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
