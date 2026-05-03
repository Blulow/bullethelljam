extends Node2D

@export var ring: Node2D

var patterns: Dictionary = {
	"tile_pattern": preload("res://scenes/patterns/tile_pattern.tscn"),
}
var bullets: Dictionary = {
	"tile_bullets": preload("res://scenes/bullets/tile_bullet.tscn"),
}
var bullet_configs: Dictionary = {
	"short_bullet_config": preload("res://scenes/bullets/bullet_configs/short_bullet_config.tres"),
	"wide_bullet_config": preload("res://scenes/bullets/bullet_configs/wide_bullet_config.tres"),
}

func _ready() -> void:
	#start_pattern("tile_pattern", "tile_bullets", "short_bullet_config")
	start_pattern("tile_pattern", "tile_bullets", "wide_bullet_config")

func start_pattern(pattern_id: String, bullet_id: String, bullet_config: String) -> void:
	var pattern: SpawnPattern
	if pattern_id:
		pattern = patterns[pattern_id].instantiate()
	if pattern:
		add_child(pattern)
		pattern.ring = ring
		if bullet_id:
			var bullet = bullets[bullet_id]
			if bullet_config:
				pattern.spawn(bullet, bullet_configs[bullet_config])
			else:
				pattern.spawn(bullet, null)
