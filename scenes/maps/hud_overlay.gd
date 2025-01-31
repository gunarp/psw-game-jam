extends CanvasLayer

@onready var hud_image = $Control/TextureRect
#@onready var experience_bar: ProgressBar = $CanvasLayer/Control/ExperienceBar

@export var player: PlayerEntity

@onready var hud_icons_container = $Control/LevelUpUI/IconContainer
@onready var level_up_ui = $Control/LevelUpUI

func _ready() -> void:
  hud_image.position = Vector2(320, 240)  # Adjust HUD (10, 10) for preferred position
  #experience_bar.position = Vector2(120, 440)
  # level_up_ui.option_selected.connect(_add_icon_to_hud)

func _add_icon_to_hud(icon_texture: Texture2D):
  var new_icon = TextureRect.new()
  new_icon.texture = icon_texture
  new_icon.custom_minimum_size = Vector2(50, 50)  # Adjust size as needed
  hud_icons_container.add_child(new_icon)  # Add to HUD
