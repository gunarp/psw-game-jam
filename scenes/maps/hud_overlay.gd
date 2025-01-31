extends CanvasLayer

@onready var hud_image = $Control/TextureRect
@onready var pause_button = $Control/TextureRect/Pause

var is_paused = false # Tracks if game is paused

func _ready() -> void:
  # Set the position of the HUD on the screen, relative to the top-left corner
  # Example: Position it in the top-left corner
  hud_image.position = Vector2(320, 240)  # Adjust (10, 10) for your preferred position

  # pause_button.rect_position = Vector2(10,10)

  # pause_button.pressed.connect(_on_pause_button_pressed)

func _on_pause_button_pressed() -> void:
  is_paused = !is_paused #Toggle pause state

  if is_paused:
    get_tree().paused = true
  else:
    get_tree().paused = false
