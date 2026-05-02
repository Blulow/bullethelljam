class_name SpawnPattern
extends Node2D

var ring: Node2D

var shooter_scene: PackedScene = preload("res://scenes/shooter.tscn")
var bullet_scene: PackedScene

func spawn(bullet: PackedScene) -> void:
	bullet_scene = bullet

func spawn_shooter(radius, angle, direction, bullet_data = {})-> void:
	var shooter: Node2D = shooter_scene.instantiate()
	ring.add_child(shooter)
	shooter.spawn(radius, angle, direction, bullet_data, bullet_scene, ring)

# SpawnManager
# - Pattern - spiral
# - BulletType - wide
