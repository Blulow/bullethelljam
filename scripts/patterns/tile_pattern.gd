extends SpawnPattern

func spawn(bullet: PackedScene, bullet_config: Resource) -> void:
	super(bullet, bullet_config)
	var count: int = randi_range(bullet_config.COUNT[0], bullet_config.COUNT[1])
	var radius: float = ring.get_node("Sprite2D").texture.get_size().y / 2
	var angle: float = randf() * TAU
	var direction: int = 1 if randf() > 0.5 else -1
	for i in range(count):
		spawn_shooter(radius, angle + (TAU / count) * i, direction, bullet_config)
