class_name SpawnPattern
extends Node2D

var ring: Node2D

var shooter_scene: PackedScene = preload("res://scenes/shooter.tscn")
var bullet_scene: PackedScene

func spawn(id: int, bullet: PackedScene, bullet_config: Resource, default_bpm: float) -> void:
	bullet_scene = bullet

func spawn_shooter(id: int, radius: float, angle: float, direction: float, shooter_sprite: Texture2D, bullet_color: Color, bullet_config: Resource, bpm: float) -> void:
	var shooter: Node2D = shooter_scene.instantiate()
	ring.add_child(shooter)
	shooter.id = id
	shooter.bullet_color = bullet_color
	shooter.get_node("Sprite2D").texture = shooter_sprite
	shooter.get_node("Sprite2D").offset = Vector2(0, -40)
	if bullet_config is TileBulletConfig:
		shooter.get_node("Sprite2D").scale = Vector2(0.5, 0.5)
	shooter.spawn(radius, angle, direction, bullet_config, bullet_scene, ring, bpm)
