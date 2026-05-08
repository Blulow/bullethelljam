extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var hit_count_label = $CanvasLayer/HitCount
@onready var rank_label = $CanvasLayer/RankScore

var ranks: Array[String] = ["NOHIT", "SSS", "SS", "S", "A", "B", "C", "F"]
var NOHIT: Texture2D = preload("res://assets/images/results/ranks/rank_nohit.png")
var SSS: Texture2D = preload("res://assets/images/results/ranks/rank_sss.png")
var SS: Texture2D = preload("res://assets/images/results/ranks/rank_ss.png")
var S: Texture2D = preload("res://assets/images/results/ranks/rank_s.png")
var A: Texture2D = preload("res://assets/images/results/ranks/rank_a.png")
var B: Texture2D = preload("res://assets/images/results/ranks/rank_b.png")
var C: Texture2D = preload("res://assets/images/results/ranks/rank_c.png")
var F: Texture2D = preload("res://assets/images/results/ranks/rank_f.png")

var hits: int = 0
var counting: bool = false
var hit_count: int = 0
var rank: String = ""

func _ready() -> void:
	rank_label.visible = false
	$CanvasLayer/TheEnd.visible = false
	$CanvasLayer/Retry.visible = false
	hits = GameData.hits
	rank = get_rank(hits)
	rank_label.texture = get(rank)

func _process(delta: float) -> void:
	if counting:
		if hit_count < hits:
			hit_count += 1
		else: 
			counting = false
			anim_player.play("rank")
		hit_count_label.text = str(hit_count)

func start_hit_count() -> void:
	hit_count_label.visible = true
	counting = true

func get_rank(hits: int) -> String:
	var r: String
	if hits <= 0:
		r = ranks[0]
	elif hits <= 25:
		r = ranks[1]
	elif hits <= 25:
		r = ranks[2]
	elif hits <= 50:
		r = ranks[3]
	elif hits <= 100:
		r = ranks[4]
	elif hits <= 200:
		r = ranks[5]
	elif hits <= 500:
		r = ranks[6]
	elif hits <= 500:
		r = ranks[7]
	return r
