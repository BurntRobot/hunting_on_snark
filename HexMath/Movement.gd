extends Object


func cube_distance(a: Vector3, b: Vector3):
	return [abs(a.x - b.x), abs(a.y - b.y), abs(a.z - b.z)].max()

func cube_linedraw(a: Vector3, b: Vector3):
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
