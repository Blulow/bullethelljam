extends Node2D

@export var SPEED: float = 1.0
@export var BPM: float = 100.0

@onready var timer := $Timer

var direction: int = 0
var radius: float
var angle: float

var ring: Node2D
var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")

func _ready() -> void:
	timer.wait_time = 60 / BPM

func _process(delta: float) -> void:
	angle += direction * SPEED * delta
	
	position = Vector2.from_angle(angle) * radius
	rotation = angle + PI / 2

func spawn(spawn_radius, spawn_angle, spawn_direction, spawn_ring) -> void:
	ring = spawn_ring
	angle = spawn_angle
	radius = spawn_radius - $Sprite2D.texture.get_size().y / 2
	direction = spawn_direction

func shoot() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	ring.add_child(bullet)
	bullet.modulate = Color(0, 1, 0)
	bullet.radius = radius
	bullet.shoot(global_position, global_rotation, ring)

func _on_timer_timeout() -> void:
	shoot()
