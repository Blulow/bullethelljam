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

var direction: int
var rot: float
var radius: float = 0.0
var start_radius: float = 0.0
var ring: Node2D

var t: float = 0.0
var t_out: float = 0.0

func _process(delta: float) -> void:
	t += delta * SPEED
	radius = lerp(start_radius, MIN_RADIUS, t**2)
	if radius < 0:
		t_out = t - 1
		#radius = lerp(MIN_RADIUS, start_radius, t**2)
		radius = lerp(MIN_RADIUS, ABNORMAL_END_RADIUS + 10, 1 - (1-t_out)**2)
		modulate = Color(1, 1, 0)
	#radius = lerp(start_radius, MIN_RADIUS, 1 - (1-t)**2)
	
	if ring:
		var points: PackedVector2Array = tile_bullet_helper.GeneratePolygonHelper(ANGLE, LENGTH, radius, global_rotation, self, ring)
		#var points = PackedVector2Array()
		#var i: float = -ANGLE/2 + PI/256
		#while i <= ANGLE/2 + PI/256:
			#points.append(to_local(ring.to_global(Vector2.from_angle(i + global_rotation - PI/2) * radius)))
			#i += PI/256
		#i = ANGLE/2
		#while i >= -ANGLE/2:
			#points.append(to_local(ring.to_global(Vector2.from_angle(i + global_rotation - PI/2) * (radius - LENGTH))))
			#i -= PI/256
		shape.polygon = points
		collision.polygon = points
	
	global_rotation += direction * PAN_SPEED * delta
	
	if not ABNORMAL:
		if radius <= MIN_RADIUS:
			queue_free()
	else:
		if radius >= ABNORMAL_END_RADIUS:
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
