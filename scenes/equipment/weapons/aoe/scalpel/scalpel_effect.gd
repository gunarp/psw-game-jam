extends Area2D

var base_stats: WeaponBaseStats
var player_ref: PlayerEntity


func _on_cooldown_timer_timeout() -> void:
  # activate effect
  # begin duration timer
	pass # Replace with function body.

func _on_duration_timer_timeout() -> void:
  # disble effect
  # begin cooldown timer
	pass # Replace with function body.


func _on_body_entered(body:Node2D) -> void:
  # if body is an enemy type then apply hit effect
  # also add enemy onto collision exception list.
  # begin cooldown timer to remove exception from list as well
	pass # Replace with function body.
