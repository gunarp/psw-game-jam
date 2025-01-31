extends KeyEntity

class_name KeyHalf

enum WHICH_HALF {LEFT, RIGHT}
@export var half_selection: WHICH_HALF


func _ready() -> void:
  match half_selection:
    WHICH_HALF.LEFT:
      $AnimatedSprite2D.play("left")
    WHICH_HALF.RIGHT:
      $AnimatedSprite2D.play("right")
      $CollisionPolygon2D.rotate(PI)
