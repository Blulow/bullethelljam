extends SpawnPattern

@export var MIN_RADIUS: float = 25.0
@export var MAX_RADIUS: float = 225.0

func spawn(id: int, bullet: PackedScene, bullet_config: Resource, default_bpm: float) -> void:
	super(id, bullet, bullet_config, default_bpm)
	var bpm: float = default_bpm
	if bullet_config.BPM:
		bpm = bullet_config.BPM
	
	var points: Array[Vector2] = generate_points(bullet_config.DIST)
	for point in points:
		spawn_shooter(id, point.x, point.y, 0, bullet_config, bpm)

func generate_points(dist: float) -> Array[Vector2]:
	var points: Array[Vector2]
	
	var radius = randf_range(MIN_RADIUS, MAX_RADIUS)
	var angle = randf_range(0, TAU)
	var point: Vector2 = Vector2(radius, angle)
	var attempts: int = 0
	while attempts < 1000:
		if not is_point_valid(point, points, dist):
			radius = randf_range(MIN_RADIUS, MAX_RADIUS)
			angle = randf_range(0, TAU)
			point = Vector2(radius, angle)
		else: points.append(point)
		attempts += 1
	
	return points

func is_point_valid(point: Vector2, points: Array[Vector2], dist: float) -> bool:
	if len(points) > 0:
		for p in points:
			if to_rec(point).distance_to(to_rec(p)) < dist:
				return false
	return true

func to_rec(pol: Vector2):
	return Vector2(pol.x * cos(pol.y), pol.x * sin(pol.y))
