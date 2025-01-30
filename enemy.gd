extends Node

@export var xp_value = 10 # Exp value for this enemy

var player: Node

func _ready():
	player = get_node("/main/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
