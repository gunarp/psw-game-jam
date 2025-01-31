extends CharacterBody2D

class_name KeyEntity

enum WHICH_KEY {RED, BLUE}
@export var key_selection: WHICH_KEY

signal picked_up_key

func _ready() -> void:
  match key_selection:
    WHICH_KEY.RED:
      $AnimatedSprite2D.play("red")
    WHICH_KEY.BLUE:
      $AnimatedSprite2D.play("blue")


func on_pickup() -> void:
  picked_up_key.emit()
  queue_free()