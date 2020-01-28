extends Node2D

onready var tiles = $HexMap
onready var points_tiles = $HexPoints
onready var character = $Character
onready var movement_line = $Line2D
var CENTER_OF_HEX = Vector2(12, 16)


func _process(delta):
	#  TODO: Batching player to nearest tile
	var _mouse_pos = get_local_mouse_position()
	var _tile_pos = tiles.map_to_world(tiles.world_to_map(_mouse_pos))
	var charpos_in_cube = oddq_to_cube(tiles.world_to_map(character.position))
	var mousepos_in_cube = oddq_to_cube(tiles.world_to_map(_mouse_pos))
	print("Cube: ", charpos_in_cube, mousepos_in_cube)
	_tile_pos += CENTER_OF_HEX
	movement_line.points = PoolVector2Array([])
	if character.position != _tile_pos:
		points_tiles.clear()
		var _path = PoolVector2Array([character.position, _tile_pos])
		movement_line.points = _path
		if Input.is_action_just_pressed("move"):
			character.position = _tile_pos
		points_tiles.set_cellv(tiles.world_to_map(character.position), 2)
		points_tiles.set_cellv(tiles.world_to_map(_mouse_pos), 2)
		print("Distance: ", cube_distance(charpos_in_cube, mousepos_in_cube))
		print('----- -----')

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
