extends Control

@export var player: Node2D # Assign player node in inspector

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
  if player:
    var screen_position = get_viewport().get_camera_2d().unproject_position(player.global_position) 
    global_position = screen_position
