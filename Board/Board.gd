extends Node2D

onready var map = $Map
onready var hover = $Hover
var CENTER_OF_HEX = Vector2()


func _ready():
	CENTER_OF_HEX.x = int(map.cell_size.x / 2)
	CENTER_OF_HEX.y = int(map.cell_size.y / 2)
