extends SpawnPattern

var tile_bullet_length_type: Array[String] = ["line", "short", "long"]
var tile_bullet_effect_type: Array[String] = ["panleft", "panright", "abnormal"]

var bullet_colors: Array[Color] = [Color(0, 1, 0), Color(1, 1, 0), Color(1, 0.5, 0)]

var line: Texture2D = preload("res://assets/images/shooters/line/line.PNG")
var line_panleft: Texture2D = preload("res://assets/images/shooters/line/line_panleft.PNG")
var line_panright: Texture2D = preload("res://assets/images/shooters/line/line_panright.PNG")
var line_abnormal: Texture2D = preload("res://assets/images/shooters/line/line_abnormal.PNG")
var short: Texture2D = preload("res://assets/images/shooters/short/short.PNG")
var short_panleft: Texture2D = preload("res://assets/images/shooters/short/short_panleft.PNG")
var short_panright: Texture2D = preload("res://assets/images/shooters/short/short_panright.PNG")
var short_abnormal: Texture2D = preload("res://assets/images/shooters/short/short_abnormal.PNG")
var long: Texture2D = preload("res://assets/images/shooters/long/long.PNG")
var long_panleft: Texture2D = preload("res://assets/images/shooters/long/long_panleft.PNG")
var long_panright: Texture2D = preload("res://assets/images/shooters/long/long_panright.PNG")
var long_abnormal: Texture2D = preload("res://assets/images/shooters/long/long_abnormal.PNG")

func spawn(id: int, bullet: PackedScene, bullet_config: Resource, default_bpm: float) -> void:
	super(id, bullet, bullet_config, default_bpm)
	var bpm: float = default_bpm
	if bullet_config.BPM:
		bpm = bullet_config.BPM
	
	var count: int = randi_range(bullet_config.COUNT[0], bullet_config.COUNT[1])
	var radius: float = 900 / 2
	var angle: float = randf() * TAU
	var direction: float = bullet_config.SPAWNER_DIRECTION
	var shooter_data: Array = get_tile_shooter_texture_and_color(bullet_config.ANGLE, bullet_config.DIRECTION, bullet_config.ABNORMAL)
	var texture: Texture2D = shooter_data[0]
	var bullet_color: Color = shooter_data[1]
	for i in range(count):
		spawn_shooter(id, radius, angle + (TAU / count) * i, direction, texture, bullet_color, bullet_config, bpm)

func get_tile_shooter_texture_and_color(angle: float, direction: float, abnormal: bool) -> Array:
	var texture_name: String = ""
	var length_type: String = ""
	var effect_type: String = ""
	
	var bullet_color: Color
	
	if angle <= PI/64:
		length_type = tile_bullet_length_type[0]
		bullet_color = bullet_colors[0]
	elif angle <= PI/4:
		length_type = tile_bullet_length_type[1]
		bullet_color = bullet_colors[1]
	else: 
		length_type = tile_bullet_length_type[2]
		bullet_color = bullet_colors[2]
	
	if abnormal:
		effect_type = tile_bullet_effect_type[2]
	elif direction < 0:
		effect_type = tile_bullet_effect_type[0]
	elif direction > 0:
		effect_type = tile_bullet_effect_type[1]
	
	texture_name = length_type + ("_" if effect_type else "") + effect_type
	return [get(texture_name), bullet_color]
