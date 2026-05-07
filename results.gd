extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var hit_count_label = $CanvasLayer/HitCount
@onready var rank_label = $CanvasLayer/RankScore

var hits: int = 100
var counting: bool = false
var hit_count: int = 0
var rank: String = "S"

func _ready() -> void:
	rank_label.text = rank

func _process(delta: float) -> void:
	if counting:
		if hit_count < 100:
			hit_count += 1
		else: 
			counting = false
			anim_player.play("rank")
		hit_count_label.text = str(hit_count)

func start_hit_count() -> void:
	hit_count_label.visible = true
	counting = true
