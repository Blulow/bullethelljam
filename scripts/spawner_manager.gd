extends Node2D

@export var ring: Node2D

var patterns: Dictionary = {
	"tap_notes": preload("res://scenes/patterns/tap_notes.tscn")
}

func _ready() -> void:
	start_pattern("tap_notes")

func start_pattern(id: String) -> void:
	var pattern: SpawnPattern
	if id:
		pattern = patterns[id].instantiate()
	if pattern:
		add_child(pattern)
		pattern.ring = ring
		pattern.spawn()
