extends Node2D

@export var ring: Node2D

@onready var song = $AudioStreamPlayer

var bossfight: Resource = preload("res://aseets/resources/levels/bossfight.tres")
var patterns: Dictionary = {
	Pattern.BulletPattern.TILE_PATTERN: preload("res://scenes/patterns/tile_pattern.tscn"),
}
var bullets: Dictionary = {
	Pattern.BulletType.TILE_BULLET: preload("res://scenes/bullets/tile_bullet.tscn"),
}

var time: float = 0.0
var bpm: float = 0.0
var current_level: Resource
var events_id: Dictionary

func _ready() -> void:
	time = 104
	start_level(bossfight)

func _process(delta: float) -> void:
	if not current_level:
		return
	
	var level_events: Array[LevelEvents] = current_level.level_events
	level_events.sort_custom(func(a, b): return a.time > b.time)
	for events in level_events:
		if time >= events.time:
			for event in events.events:
					match event.event_type:
						LevelEvent.EventType.START:
							if not events_id.has(event.id):
								var pattern: Pattern = event.pattern
								start_pattern(event.id, pattern.bullet_pattern, pattern.bullet_type, pattern.bullet_config)
						LevelEvent.EventType.STOP:
							if events_id.has(event.id):
								stop_pattern(event.id)
			break
	
	time += delta

func start_level(level: Resource) -> void:
	bpm = level.bpm
	current_level = level
	song.stream = level.song
	await get_tree().create_timer(2 * 60.0 / bpm).timeout
	song.play(time - 2 * 60.0 / bpm)

func start_pattern(id: int, pattern_id: Pattern.BulletPattern, bullet_id: Pattern.BulletType, bullet_config: BulletConfig) -> void:
	var pattern: SpawnPattern
	if pattern_id != null:
		pattern = patterns[pattern_id].instantiate()
		events_id[id] = pattern
	if pattern:
		add_child(pattern)
		pattern.ring = ring
		if bullet_id != null:
			var bullet = bullets[bullet_id]
			if bullet_config != null:
				pattern.spawn(id, bullet, bullet_config, bpm)

func stop_pattern(id: int) -> void:
	if events_id[id]:
		events_id[id].queue_free()
		events_id.erase(id)
	
	for obj in ring.get_children():
		if "id" in obj:
			if obj.id == id:
				obj.queue_free()
