extends SpawnPattern

func spawn(id: int, bullet: PackedScene, bullet_config: Resource, default_bpm: float) -> void:
	super(id, bullet, bullet_config, default_bpm)
	var bpm: float = default_bpm
	if bullet_config.BPM:
		bpm = bullet_config.BPM
	
	var count: int = randi_range(bullet_config.COUNT[0], bullet_config.COUNT[1])
	var radius: float = ring.get_node("Sprite2D").texture.get_size().y / 2
	var angle: float = randf() * TAU
	var direction: int = 1 if randf() > 0.5 else -1
	if bullet_config.SPAWNER_DIRECTION >= -1 and bullet_config.SPAWNER_DIRECTION <= 1:
		direction = bullet_config.SPAWNER_DIRECTION
	for i in range(count):
		spawn_shooter(id, radius, angle + (TAU / count) * i, direction, bullet_config, bpm)
