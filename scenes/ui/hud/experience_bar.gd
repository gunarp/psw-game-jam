extends ProgressBar

@export var player_experience: EntityExperience

func _ready() -> void:
  value = player_experience.current_experience
  max_value = player_experience.level_up_threshhold


func _process(_delta: float) -> void:
  value = player_experience.current_experience


func _on_level_up(new_max: float) -> void:
  self.max_value = new_max
  value = 0
