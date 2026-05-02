extends Area2D

@export var SPEED = 100.0

var direction: Vector2

func _process(delta: float) -> void:
	position += direction * SPEED * delta

func shoot(pos: Vector2, rot: float) -> void:
	global_position = pos
	global_rotation = rot
	
	direction = Vector2.from_angle(rot + PI / 2)
	print(direction)

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("inner_ring"):
		queue_free()
