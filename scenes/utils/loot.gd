extends RigidBody2D

class_name Loot
#var loot_to_spawn: PackedScene

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
  #pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
  #pass

func _physics_process(_delta: float) -> void:
  pass
  
func on_player_collision() -> void:
  queue_free()
  pass
