extends SpawnPattern

func spawn(bullet: PackedScene) -> void:
	super(bullet)
	var count: int = randi_range(4, 7)
	var radius: float = ring.get_node("Sprite2D").texture.get_size().y / 2
	var angle: float = randf() * TAU
	var direction: int = 1 if randf() > 0.5 else -1
	for i in range(count):
		spawn_shooter(radius, angle + (TAU / count) * i, direction)
