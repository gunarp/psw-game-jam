extends CanvasLayer

@onready var hud_image = $Control/TextureRect
@onready var experience_bar: ProgressBar = $ExperienceBar

@export var player: PlayerEntity

func _ready() -> void:
  hud_image.position = Vector2(320, 240)  # Adjust HUD (10, 10) for preferred position
  experience_bar.position = Vector2(120, 440) 
    
  
# Center the ProgressBar on the screen
#var screen_center = get_viewport().get_visible_rect().size / 2
#var bar_width = experience_bar.size.x  # Get the width of the ProgressBar
#var bar_height = experience_bar.size.y  # Get the height of the ProgressBar
#experience_bar.rect_position = screen_center - Vector2(bar_width / 2, bar_height / 2)
