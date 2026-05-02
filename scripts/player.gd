extends Area2D

@export var HORIZONTAL_SPEED: float = 5.0
@export var VERTICAL_SPEED: float = 200.0
@export var MIN_RADIUS: float = 25.0
@export var MAX_RADIUS: float = 225.0

var radius: float = 0.0
var direction: Vector2
var angle: float = 0.0

func _ready() -> void:
	radius = MIN_RADIUS

func _process(delta: float) -> void:
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	
	if Input.is_action_pressed("ui_up"):
		if (radius < MAX_RADIUS):
			direction.y += 1
	if Input.is_action_pressed("ui_down"):
		if (radius > MIN_RADIUS):
			direction.y -= 1
	
	angle += direction.x * HORIZONTAL_SPEED * delta
	radius += direction.y * VERTICAL_SPEED * delta
	
	position = Vector2.from_angle(angle) * radius
	
