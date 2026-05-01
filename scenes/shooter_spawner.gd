extends Node2D

@export var ring: Node2D

var shooter_scene: PackedScene = preload("res://scenes/shooter.tscn")

func _ready() -> void:
	spawn_shooter()

func spawn_shooter() -> void:
	var shooter: Node2D = shooter_scene.instantiate()
	ring.add_child(shooter)
	
	var radius: float = ring.get_node("Sprite2D").texture.get_size().y / 2
	var angle: float = randf() * TAU
	shooter.spawn(radius, angle)
