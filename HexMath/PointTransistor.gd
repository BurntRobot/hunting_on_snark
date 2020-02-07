extends Object

class_name PointTransistor


static func oddq_to_cube(_hex: Vector2):
	var x0 = _hex.x
	var z0 = _hex.y - (_hex.x - (int(_hex.x)&1)) / 2
	var y0 = -x0-z0
	return Vector3(x0, y0, z0)

static func cube_to_oddq(_cube: Vector3):
	var x0 = _cube.x
	var y0 = _cube.z + (_cube.x - (int(_cube.x)&1)) / 2
	return Vector2(x0, y0)

static func cube_to_axial(_cube: Vector3):
	var q = _cube.x
	var r = _cube.z
	return Vector2(q, r)

static func axial_to_cube(_hex: Vector2):
	var x0 = _hex.x
	var z0 = _hex.y
	var y0 = -x0-z0
	return Vector3(x0, y0, z0)
