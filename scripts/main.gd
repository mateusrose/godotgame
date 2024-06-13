extends Node2D
class_name Main
@onready var player: CharacterBody2D = $Player
@onready var background = $Background
@onready var canvas = $CanvasModulate
const NIGHT_COLOR = Color("#0c0219")
const DAY_COLOR = Color(0.45,0.45,0.45,1)
const NIGHT_COLOR_STUFF = Color("#ffffff")
const DAY_COLOR_STUFF = Color("#000000")
var is_day = true
var time = 0
const TIME_SCALE = 0.005
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta:float):
	self.time += delta * TIME_SCALE
	background.set_color(DAY_COLOR.lerp(NIGHT_COLOR, abs(sin(time))))
	%Light.color = DAY_COLOR_STUFF.lerp(NIGHT_COLOR_STUFF, abs(sin(time)))
	if abs(sin(time)) <= 0.4:
		is_day = true
		return
	is_day=false
	#canvas.color = DAY_COLOR_STUFF.lerp(NIGHT_COLOR_STUFF, abs(sin(time)))

func _on_game_over() -> void:
	var _reload: bool = get_tree().reload_current_scene()
