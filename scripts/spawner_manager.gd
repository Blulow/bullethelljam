extends Node2D

@export var ring: Node2D

var patterns: Dictionary = {
	"tile_pattern": preload("res://scenes/patterns/tile_pattern.tscn"),
}
var bullets: Dictionary = {
	"tile_bullets": preload("res://scenes/bullets/tile_bullet.tscn"),
}

func _ready() -> void:
	start_pattern("tile_pattern", "tile_bullets")

func start_pattern(pattern_id: String, bullet_id: String) -> void:
	var pattern: SpawnPattern
	if pattern_id:
		pattern = patterns[pattern_id].instantiate()
	if pattern:
		add_child(pattern)
		pattern.ring = ring
		if bullet_id:
			var bullet = bullets[bullet_id]
			pattern.spawn(bullet)
