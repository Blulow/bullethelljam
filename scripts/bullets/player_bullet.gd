extends Bullet

@export var SPEED: float = 1000.0

@onready var sprite = $Sprite2D

var direction: Vector2

func _process(delta: float) -> void:
	if direction:
		position += direction * SPEED * delta
		sprite.visible = true

func shoot(pos: Vector2, rot: float, spawn_ring: Node2D) -> void:
	global_position = pos
	global_rotation = rot + PI
	direction = Vector2.from_angle(rot + PI / 2)
