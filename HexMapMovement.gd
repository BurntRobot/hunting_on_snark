extends Node2D

onready var tiles = $HexMap
onready var character = $Character
onready var movement_line = $Line2D
var CENTER_OF_HEX = Vector2(12, 16)


func _process(delta):
	var _mouse_pos = get_local_mouse_position()
	var _tile_pos = tiles.map_to_world(tiles.world_to_map(_mouse_pos))
	print(tiles.world_to_map(character.position), tiles.world_to_map(_mouse_pos))  # Ключ для определения длины линии
	_tile_pos += CENTER_OF_HEX
	movement_line.points = PoolVector2Array([])
	if character.position != _tile_pos:
		var _path = PoolVector2Array([character.position, _tile_pos])
		movement_line.points = _path
		if Input.is_action_just_pressed("move"):
			character.position = _tile_pos
		print(tiles.world_to_map(character.position).distance_to(tiles.world_to_map(_mouse_pos)))
