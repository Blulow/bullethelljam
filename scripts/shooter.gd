extends Node2D

@export var SPEED: float = 1.0

@onready var timer := $Timer

var id: int

var bpm: float
var direction: float = 0.0
var radius: float
var angle: float
var bullet_config: Resource

var ring: Node2D
var bullet_scene: PackedScene

var bullet_color: Color

var shoot_anim: bool = false

func _process(delta: float) -> void:
	if shoot_anim:
		if $Sprite2D.scale.y < 0.6:
			$Sprite2D.scale.y += 0.1
		else:
			shoot_anim = false
	else:
		if $Sprite2D.scale.y > 0.5:
			$Sprite2D.scale.y -= 0.01
	
	angle += direction * SPEED * delta
	
	position = Vector2.from_angle(angle) * radius
	rotation = angle + PI / 2

func spawn(spawn_radius: float, spawn_angle: float, spawn_direction: float, spawn_bullet_config: Resource, spawn_bullet_scene: PackedScene, spawn_ring: Node2D, spawn_bpm: float) -> void:
	bpm = spawn_bpm
	timer.wait_time = 60 / bpm
	
	bullet_scene = spawn_bullet_scene
	ring = spawn_ring
	angle = spawn_angle
	radius = spawn_radius - ($Sprite2D.texture.get_size().y / 2 if $Sprite2D.texture else 0) 
	direction = spawn_direction
	if spawn_bullet_config:
		bullet_config = spawn_bullet_config

func shoot() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	ring.add_child(bullet)
	bullet.get_node("Sprite").modulate = bullet_color
	if "radius" in bullet:
		bullet.radius = radius
	if "id" in bullet:
		bullet.id = id
	shoot_anim = true
	bullet.shoot(global_position, global_rotation, ring, bullet_config)

func _on_timer_timeout() -> void:
	shoot()
