extends Area2D

@export var HORIZONTAL_SPEED: float = 300.0
@export var VERTICAL_SPEED: float = 300.0
@export var MIN_RADIUS: float = 37.0
@export var MAX_RADIUS: float = 283.0
@export var ring: Node2D
@export var hits_label: Label

@export var SHRINK_COOLDOWN: float = 1.0
@export var SHRINK_USE_COOLDOWN: float = 3.0

var radius: float = 0.0
var direction: Vector2
var angle: float = 0.0

var hits: int = 0

var shrink: bool = false
var shrink_timer: float = 0.0
var shrink_use_timer: float = 0.0
var shrink_disabled: bool = false

var bullet_scene: PackedScene = preload("res://scenes/bullets/player_bullet.tscn")

func _ready() -> void:
	radius = MIN_RADIUS + $Sprite2D.texture.get_size().y / 2

func _process(delta: float) -> void:
	if not shrink_disabled:
		if Input.is_action_pressed("shrink"):
			shrink = true
	
	if shrink:
		if shrink_timer < SHRINK_COOLDOWN:
			collision_layer = 2
			
			if $Sprite2D.scale > Vector2.ZERO:
				$Sprite2D.scale -= Vector2.ONE * 0.1
			
			shrink_timer += delta
			$Cooldowns/ShrinkCooldown.visible = true
			$Cooldowns/ShrinkCooldown.value = shrink_timer / SHRINK_COOLDOWN * 100
		else:
			shrink = false
			shrink_disabled = true
			$Cooldowns/ShrinkCooldown.value = 0
		if Input.is_action_just_released("shrink"):
			shrink = false
			shrink_disabled = true
			$Cooldowns/ShrinkCooldown.value = 0
	else:
		$Cooldowns/ShrinkCooldown.visible = false
		shrink_timer = 0.0
		collision_layer = 1
			
		if shrink_disabled:
			if shrink_use_timer < SHRINK_USE_COOLDOWN:
				$Cooldowns/ShrinkUseCooldown.visible = true
				$Cooldowns/ShrinkUseCooldown.value = shrink_use_timer / SHRINK_USE_COOLDOWN * 100
				shrink_use_timer += delta
			else:
				$Cooldowns/ShrinkUseCooldown.visible = false
				shrink_use_timer = 0.0
				shrink_disabled = false
		
		if $Sprite2D.scale < Vector2.ONE * 0.5:
			$Sprite2D.scale += Vector2.ONE * 0.1
		
		direction = Vector2.ZERO
	
		var step = 1/radius
		if Input.is_action_pressed("left"):
			direction.x -= step
		if Input.is_action_pressed("right"):
			direction.x += step
		
		if Input.is_action_pressed("up"):
			if (radius < MAX_RADIUS - $Sprite2D.texture.get_size().y / 2):
				direction.y += 1
		if Input.is_action_pressed("down"):
			if (radius > MIN_RADIUS + $Sprite2D.texture.get_size().y / 2):
				direction.y -= 1
		
		#if Input.is_action_just_pressed("ui_accept"):
			#shoot()
		
		angle += direction.x * HORIZONTAL_SPEED * delta
		radius += direction.y * VERTICAL_SPEED * delta
		
		position = Vector2.from_angle(angle) * radius
		rotation = angle
		
		$Cooldowns.global_rotation = 0

func shoot() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	ring.add_child(bullet)
	bullet.shoot(global_position, global_rotation - PI / 2, ring)

func hit() -> void:
	GameData.hits += 1
	hits = GameData.hits
	hits_label.text = "Hits: " + str(hits)
	
