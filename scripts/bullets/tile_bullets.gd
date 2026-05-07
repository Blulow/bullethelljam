extends Bullet

@export var SPEED: float = 1.0
@export var ANGLE: float
@export var LENGTH: float
@export var ABNORMAL: bool
@export var ABNORMAL_END_RADIUS: float = 450.0
@export var MIN_RADIUS: float = 25.0
@export var PAN_SPEED: float = 3.0
var config: Resource

@onready var shape = $Polygon2D
@onready var collision = $CollisionPolygon2D
@onready var tile_bullet_helper = preload("res://scripts/bullets/TileBulletHelper.cs").new()

var direction: float
var rot: float
var radius: float = 0.0
var start_radius: float = 0.0
var ring: Node2D

var t: float = 0.0
var t_out: float = 0.0

func _physics_process(delta: float) -> void:
	if ring:
		shape.polygon = tile_bullet_helper.GeneratePolygonHelper(ANGLE, LENGTH, radius, 20, global_rotation, self, ring)
		collision.polygon = tile_bullet_helper.GeneratePolygonHelper(ANGLE, LENGTH, radius, 5, global_rotation, self, ring)

func _process(delta: float) -> void:
	t += delta * SPEED
	radius = lerp(start_radius, MIN_RADIUS, t**2)
	if radius < 0:
		t_out = t - 1
		radius = lerp(-MIN_RADIUS, -ABNORMAL_END_RADIUS - 10, 1 - (1-t_out)**2)
		modulate = Color(1, 1, 0)
	
	global_rotation += direction * PAN_SPEED * delta
	position = to_rec(Vector2(radius, global_rotation - PI / 2))
	
	if ABNORMAL:
		if radius <= -ABNORMAL_END_RADIUS:
			queue_free()

func shoot(pos: Vector2, rot: float, spawn_ring: Node2D, spawn_config: Resource = null) -> void:
	ring = spawn_ring
	global_position = pos
	global_rotation = rot
	start_radius = radius
	config = spawn_config
	load_bullet_config(spawn_config)

func load_bullet_config(bullet_config: TileBulletConfig) -> void:
	if not bullet_config:
		return
	
	ANGLE = bullet_config.ANGLE
	LENGTH = bullet_config.LENGTH
	ABNORMAL = bullet_config.ABNORMAL
	direction = bullet_config.DIRECTION

func to_rec(pol: Vector2):
	return Vector2(pol.x * cos(pol.y), pol.x * sin(pol.y))

func _on_area_entered(area: Area2D) -> void:
	super(area)
	if not ABNORMAL:
		if area.is_in_group("inner_ring"):
			queue_free()
