extends Node2D

@export var SPEED: float = 1.0

var direction: int = 0
var radius: float
var angle: float

func _process(delta: float) -> void:
	angle += direction * SPEED * delta
	
	position = Vector2(cos(angle), sin(angle)) * radius
	rotation = angle + PI / 2

func spawn(spawn_radius, spawn_angle) -> void:
	angle = spawn_angle
	radius = spawn_radius - $Sprite2D.texture.get_size().y / 2
	direction = 1 if randf() > 0.5 else -1
