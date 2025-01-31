extends ProgressBar

@export var player_experience: EntityExperience

func _ready() -> void:
  value = 0
  max_value = 50


func _process(_delta: float) -> void:
  value = player_experience.current_experience


func _on_level_up(new_max: float) -> void:
  self.max_value = new_max
  value = 0
