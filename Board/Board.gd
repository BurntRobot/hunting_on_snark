extends Node2D

onready var map = $Map
onready var hover = $Hover
var CENTER_OF_HEX = Vector2()
onready var point_transistor = PointTransistor


func _ready():
	CENTER_OF_HEX.x = int(map.cell_size.x / 2)
	CENTER_OF_HEX.y = int(map.cell_size.y / 2)

func inline_with_map(object_position: Vector2):
	var map_position = map.map_to_world(map.world_to_map(object_position))
	map_position += CENTER_OF_HEX
	return map_position

func get_cube_position(position: Vector2):
	var cube_position = map.world_to_map(position)
	cube_position = point_transistor.oddq_to_cube(cube_position)
	return cube_position
