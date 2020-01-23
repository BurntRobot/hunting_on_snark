extends Node2D

onready var tiles = $HexMap
onready var character = $Character
var CENTER_OF_HEX = Vector2(12, 16)


func _process(delta):
	var _mouse_pos = get_local_mouse_position()
	var _tile_pos = tiles.map_to_world(tiles.world_to_map(_mouse_pos)) + CENTER_OF_HEX
	if character.position != _tile_pos and Input.is_action_just_pressed("move"):
		character.position = _tile_pos
	print(_tile_pos)
