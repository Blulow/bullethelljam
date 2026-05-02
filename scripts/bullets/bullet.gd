class_name Bullet
extends Area2D

func shoot(pos: Vector2, rot: float, spawn_ring: Node2D) -> void:
	pass

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("inner_ring"):
		queue_free()
