class_name SpawnPattern
extends Node2D

var ring: Node2D

var shooter_scene: PackedScene = preload("res://scenes/shooter.tscn")

func spawn() -> void:
	pass

func spawn_shooter(radius, angle, direction) -> void:
	var shooter: Node2D = shooter_scene.instantiate()
	ring.add_child(shooter)
	shooter.spawn(radius, angle, direction, ring)
