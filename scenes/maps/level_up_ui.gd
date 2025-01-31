extends Control

# signal option_selected(icon_texture)

signal upgrade_selected(upgrade_name)
@onready var icon_container = $IconContainer
@onready var icon_scene = preload("res://scenes/level_up_ui.tscn")
@export var option_icons: Array[Texture2D]  # Array of possible icons
@export var option_scenes: Array[PackedScene] = [] # Array of corresponding scenes

@onready var names: Array[String] = ["mole", "scalpel", "needle", "flail", "sugar", "mito", "atp", "ribos", "golgi"]

var selected_upgrades: Dictionary = {} # Dictionary to store selected upgrades (icon to scene)
var selected_option: Texture2D

var is_first_run: bool = true

func _ready():
  # Hide UI initially
  visible = false

#func _process(_delta):
  #if Input.is_action_just_pressed("level_up_test"):  # Press L key to lvl up, to be removed
    #show_options()


func _on_experience_exp_level_up(_level_up_threshhold: float) -> void:
  show_options()


func show_options():
  visible = true

  var idxs = {}
  while idxs.size() < 3:
    idxs[randi_range(0, names.size() - 1)] = true

  for i in range(3):
    var button = $IconContainer.get_child(i)  # Get the button
    var texture_rect = button.get_node("TextureRect")  # Get icon
    texture_rect.texture = option_icons[idxs.keys()[i]]  # Assign random icon
    button.upgrade_name = names[idxs.keys()[i]]
    if is_first_run:
      button.pressed.connect(_on_option_selected2.bind(button))
  
  is_first_run = false  

func _on_option_selected2(button: Button):
  upgrade_selected.emit(button.upgrade_name)
  visible = false
