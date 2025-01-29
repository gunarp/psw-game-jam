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


func _on_main_region_area_entered(area:Area2D) -> void:
	print("entered main region")


func _on_heart_region_area_entered(area:Area2D) -> void:
	print("entered heart")


func _on_lung_region_area_entered(area:Area2D) -> void:
	print("entered lungs")


func _on_stomatch_region_area_entered(area:Area2D) -> void:
	print("entered stomach")


func _on_brain_region_area_entered(area:Area2D) -> void:
	print("entered brain")
