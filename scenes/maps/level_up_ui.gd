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

func _ready():
    # Hide UI initially
    visible = false

func _process(_delta):
    if Input.is_action_just_pressed("level_up_test"):  # Press L key to lvl up, to be removed
        show_options()

func show_options():
    visible = true
    var shuffled_options = option_icons.duplicate()
    shuffled_options.shuffle()

    var idxs = {}
    while idxs.size() < 3:
      idxs[randi_range(0, names.size())] = true

    for i in range(3):
        var button = $IconContainer.get_child(i)  # Get the button
        var texture_rect = button.get_node("TextureRect")  # Get icon
        texture_rect.texture = option_icons[idxs.keys()[i]]  # Assign random icon

        # Connect the button press event
        # button.pressed.connect(_on_option_selected.bind(names[i]))
        button.pressed.connect(_on_option_selected2.bind(names[idxs.keys()[i]]))

func _on_option_selected(icon_texture: Texture2D):
  selected_option = icon_texture
  var upgrade_name = selected_option.resource_name
  var index = option_icons.find(icon_texture)
  print("ahhahef ", upgrade_name)

  if index != -1 and index < option_scenes.size():
    # var selected_scene = option_scenes[index]  # Get the corresponding scene
      # Save selection as entry (icon to scene)
    # if icon_texture.resource_path not in selected_upgrades:
    #   selected_upgrades[icon_texture.resource_path] = selected_scene
    hide()


func _on_option_selected2(upgrade_name: String):
  print(upgrade_name)


func spawn_upgrade(icon_texture: Texture2D, position: Vector2):
    if icon_texture.resource_path in selected_upgrades:
      var upgrade_scene = selected_upgrades[icon_texture.resource_path]
      if upgrade_scene:
        var instance = upgrade_scene.instantiate()
        get_tree().current_scene.add_child(instance)
        instance.global_position = position


func _on_option_3_pressed() -> void:
  pass # Replace with function body.

func _on_option_2_pressed() -> void:
  pass # Replace with function body.

func _on_option_1_pressed() -> void:
  pass # Replace with function body.
