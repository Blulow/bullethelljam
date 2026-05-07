extends Bullet

@export var SPEED: float = 1.0
@export var SIZE: float
@export var STAY: bool
@export var TELEGRAPH_TIME: float = 1.0
var config: Resource
var id: int

@onready var shape = $Sprite/MeshInstance2D
@onready var collision = $CollisionShape2D
@onready var telegraph = $Telegraph

var ring: Node2D

var telegraphed: bool = false
var telegraphed_timer: float = 0.0
var expanded: bool = false
var stay_timer: float = 0.0

func _physics_process(delta: float) -> void:
	if not telegraphed and not expanded:
		telegraph.visible = true
		telegraphed_timer += delta
	elif telegraphed and not expanded:
		if not shape.visible: shape.visible = true
		if not collision.visible: collision.visible = true
		if shape.scale < Vector2.ONE:
			shape.scale += Vector2.ONE * 0.01 * SPEED
		if collision.scale < Vector2.ONE:
			collision.scale += Vector2.ONE * 0.01 * SPEED
		
		if shape.scale >= Vector2.ONE and collision.scale >= Vector2.ONE:
			expanded = true
	
	if telegraphed_timer >= TELEGRAPH_TIME / SPEED:
		telegraphed = true
	
	if not STAY:
		if expanded:
			if modulate.a > 0:
				modulate.a -= 0.01 * SPEED
		if modulate.a <= 0:
			queue_free()

func shoot(pos: Vector2, rot: float, spawn_ring: Node2D, spawn_config: Resource = null) -> void:
	ring = spawn_ring
	global_position = pos
	global_rotation = rot
	config = spawn_config
	load_bullet_config(spawn_config)
	scale = Vector2.ONE * SIZE
	shape.scale = Vector2.ZERO
	collision.scale = Vector2.ZERO

func load_bullet_config(bullet_config: DotBulletConfig) -> void:
	if not bullet_config:
		return
	
	SPEED = bullet_config.SPEED
	SIZE = bullet_config.SIZE
	STAY = bullet_config.STAY
	TELEGRAPH_TIME = bullet_config.TELEGRAPH_TIME

func _on_area_entered(area: Area2D) -> void:
	super(area)
