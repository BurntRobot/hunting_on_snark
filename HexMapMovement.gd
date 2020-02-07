extends Node2D

onready var board = $Board
onready var tiles = $Board/Map
onready var points_tiles = $Board/Hover
onready var character = $Character
onready var point_transistor = PointTransistor


func _process(delta):
	character.position = board.inline_with_map(character.position)
	
	var _mouse_pos = get_local_mouse_position()
	var mousepos_in_cube = board.get_cube_position(_mouse_pos)
	var charpos_in_cube = board.get_cube_position(character.position)
	var tile_under_mouse = tiles.map_to_world(tiles.world_to_map(_mouse_pos)) + $Board.CENTER_OF_HEX
	
	if character.position != tile_under_mouse:
		points_tiles.clear()
		var _path = PoolVector2Array([character.position, tile_under_mouse])
		points_tiles.set_cellv(tiles.world_to_map(character.position), 2)
		points_tiles.set_cellv(tiles.world_to_map(_mouse_pos), 2)
		var _cube_points = cube_linedraw(charpos_in_cube, mousepos_in_cube)
		var _points = []
		for i in _cube_points:
			_points.append(tiles.map_to_world(point_transistor.cube_to_oddq(i)) + $Board.CENTER_OF_HEX)
			points_tiles.set_cellv(point_transistor.cube_to_oddq(i), 2)
		_path = PoolVector2Array(_points)
		
		if character.steps == 2 and len(_cube_points) == 2:
			for i in range(0, 2):
				points_tiles.set_cellv(point_transistor.cube_to_oddq(_cube_points[i]), 3)
			if Input.is_action_just_pressed("move"):
				character.position = _path[1]
		else:
			for i in range(0, character.steps+1):
				points_tiles.set_cellv(point_transistor.cube_to_oddq(_cube_points[i]), 3)
			if Input.is_action_just_pressed("move"):
				character.position = _path[character.steps]
