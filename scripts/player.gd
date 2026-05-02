extends Area2D

@export var HORIZONTAL_SPEED: float = 5.0
@export var VERTICAL_SPEED: float = 200.0
@export var MIN_RADIUS: float = 25.0
@export var MAX_RADIUS: float = 225.0
@export var BULLET_SPEED: float = 1000.0
@export var ring: Node2D

var radius: float = 0.0
var direction: Vector2
var angle: float = 0.0

var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")

func _ready() -> void:
	radius = MIN_RADIUS + $Sprite2D.texture.get_size().y / 2

func _process(delta: float) -> void:
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	
	if Input.is_action_pressed("ui_up"):
		if (radius < MAX_RADIUS - $Sprite2D.texture.get_size().y / 2):
			direction.y += 1
	if Input.is_action_pressed("ui_down"):
		if (radius > MIN_RADIUS + $Sprite2D.texture.get_size().y / 2):
			direction.y -= 1
	
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
	
	angle += direction.x * HORIZONTAL_SPEED * delta
	radius += direction.y * VERTICAL_SPEED * delta
	
	position = Vector2.from_angle(angle) * radius
	rotation = angle

func shoot() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	ring.add_child(bullet)
	bullet.modulate = Color(1, 0, 1)
	bullet.SPEED = BULLET_SPEED
	bullet.player_shoot(global_position, global_rotation - PI / 2)
