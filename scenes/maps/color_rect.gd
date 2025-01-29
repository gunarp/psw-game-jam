extends Node2D

var player_position = Vector2(0, 0)  # Default player position
var fog_texture_rect: TextureRect

func _ready():
	fog_texture_rect = $ColorRect/CanvasLayer/FogTextureRect  # Fog texture
	var shader_material = fog_texture_rect.material
	if shader_material is ShaderMaterial:
		shader_material.set_shader_param("player_position", player_position)

func _process(delta):
	player_position = get_node("Player").position  # Assuming you have a Player node
	var shader_material = fog_texture_rect.material
	if shader_material is ShaderMaterial:
		shader_material.set_shader_param("player_position", player_position)
