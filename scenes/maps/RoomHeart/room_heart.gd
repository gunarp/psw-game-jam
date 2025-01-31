extends Node2D

class_name RoomHeart

var placed_pieces = {}
var num_expected = 3

func _ready() -> void:
  $KeyRed.visible = false
  $KeyRed/CollisionPolygon2D.set_deferred("disabled", true)


func _on_heart_destination_body_entered(body:Node2D) -> void:
  if body is HeartPiece:
    var destination = Vector2(0, 0)
    match body.spot:
      "left":
        destination = Vector2(-52, -38)
      "right":
        destination = Vector2(52, -39)
      "bottom":
        destination = Vector2(3, 31)
    body.lock_position(destination)

    placed_pieces[body.spot] = true
    if (placed_pieces.size() == num_expected):
      $KeyRed.visible = true
      $KeyRed/CollisionPolygon2D.set_deferred("disabled", false)