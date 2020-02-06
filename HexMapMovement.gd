extends Node2D

onready var tiles = $HexMap
onready var points_tiles = $HexPoints
onready var character = $Character
onready var walk_line = $WalkLine
onready var step_line = $StepLine
var CENTER_OF_HEX = Vector2(12, 16)


func _process(delta):
	# TODO: Batching player to nearest tile
	var _mouse_pos = get_local_mouse_position()
	var mousepos_in_cube = oddq_to_cube(tiles.world_to_map(_mouse_pos))
	
	var _tile_pos = tiles.map_to_world(tiles.world_to_map(_mouse_pos))
	_tile_pos += CENTER_OF_HEX
	
	character.position = tiles.map_to_world(tiles.world_to_map(character.position))
	character.position += CENTER_OF_HEX
	var charpos_in_cube = oddq_to_cube(tiles.world_to_map(character.position))
	
	if character.position != _tile_pos:
		points_tiles.clear()
		var _path = PoolVector2Array([character.position, _tile_pos])
		points_tiles.set_cellv(tiles.world_to_map(character.position), 2)
		points_tiles.set_cellv(tiles.world_to_map(_mouse_pos), 2)
		var _cube_points = cube_linedraw(charpos_in_cube, mousepos_in_cube)
		var _points = []
		for i in _cube_points:
			_points.append(tiles.map_to_world(cube_to_oddq(i))+CENTER_OF_HEX)
			points_tiles.set_cellv(cube_to_oddq(i), 2)
		_path = PoolVector2Array(_points)
		for i in range(0, character.steps+1):
			points_tiles.set_cellv(cube_to_oddq(_cube_points[i]), 3)
		
		if Input.is_action_just_pressed("move"):
			#character.position = _tile_pos
			character.position = _path[character.steps]
		#walk_line.points = _path

func cube_distance(a, b):
	return [abs(a.x - b.x), abs(a.y - b.y), abs(a.z - b.z)].max()

func oddq_to_cube(_hex: Vector2):
	var x0 = _hex.x
	var z0 = _hex.y - (_hex.x - (int(_hex.x)&1)) / 2
	var y0 = -x0-z0
	return Vector3(x0, y0, z0)

func cube_to_oddq(_cube: Vector3):
	var x0 = _cube.x
	var y0 = _cube.z + (_cube.x - (int(_cube.x)&1)) / 2
	return Vector2(x0, y0)

func cube_to_axial(_cube: Vector3):
	var q = _cube.x
	var r = _cube.z
	return Vector2(q, r)

func axial_to_cube(_hex: Vector2):
	var x0 = _hex.x
	var z0 = _hex.y
	var y0 = -x0-z0
	return Vector3(x0, y0, z0)

func cube_linedraw(a, b):
	var N = cube_distance(a, b)
	var results = []
	for i in range(0, N+1):
		results.append(cube_round(cube_lerp(a, b, 1.0/N * i)))
	return results

func cube_lerp(a, b, t):
	return Vector3(lerp_axis(a.x, b.x, t), 
				   lerp_axis(a.y, b.y, t),
				   lerp_axis(a.z, b.z, t))

func lerp_axis(a, b, t):
	return a + (b - a) * t

func cube_round(cube: Vector3):
	var rx = round(cube.x)
	var ry = round(cube.y)
	var rz = round(cube.z)

	var x_diff = abs(rx - cube.x)
	var y_diff = abs(ry - cube.y)
	var z_diff = abs(rz - cube.z)

	if x_diff > y_diff and x_diff > z_diff:
		rx = -ry-rz
	elif y_diff > z_diff:
		ry = -rx-rz
	else:
		rz = -rx-ry

	return Vector3(rx, ry, rz)
