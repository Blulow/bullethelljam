extends Bullet

@export var SPEED: float = 1.0
@export var ANGLE: float = PI/8
@export var LENGTH: float = 25.0
@export var ABNORMAL: bool = false
@export var MIN_RADIUS: float = 25.0

@onready var shape = $Polygon2D
@onready var collision = $CollisionPolygon2D

var direction: Vector2
var radius: float = 0.0
var start_radius: float = 0.0
var ring: Node2D

var t: float = 0.0

func _process(delta: float) -> void:
	t += delta * SPEED
	radius = lerp(start_radius, MIN_RADIUS, t * t)
	
	if ring:
		var points = PackedVector2Array()
		var i: float = -ANGLE/2 + PI/256
		while i <= ANGLE/2 + PI/256:
			points.append(to_local(ring.to_global(Vector2.from_angle(i + global_rotation - PI/2) * radius)))
			i += PI/256
		i = ANGLE/2
		while i >= -ANGLE/2:
			points.append(to_local(ring.to_global(Vector2.from_angle(i + global_rotation - PI/2) * (radius - LENGTH))))
			i -= PI/256
		shape.polygon = points
		collision.polygon = points
	
	if not ABNORMAL:
		if radius <= MIN_RADIUS:
			queue_free()

func shoot(pos: Vector2, rot: float, spawn_ring: Node2D) -> void:
	ring = spawn_ring
	global_position = pos
	global_rotation = rot
	start_radius = radius

func load_bullet_data(data: Dictionary) -> void:
	if not data:
		return
	
	if data.has("angle"):
		ANGLE = data.angle
	if data.has("length"):
		LENGTH = data.length
	if data.has("abnormal"):
		ABNORMAL = data.abnormal
