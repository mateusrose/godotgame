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
	player.get_node("Health").health_depleted.connect(_on_game_over);

func _process(delta:float):
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		$CanvasLayer/Esc.visible = true
	self.time += delta * TIME_SCALE;
	background.set_color(DAY_COLOR.lerp(NIGHT_COLOR, abs(sin(time))));
	%Light.color = DAY_COLOR_STUFF.lerp(NIGHT_COLOR_STUFF, abs(sin(time)));
	if abs(sin(time)) <= 0.4:
		is_day = true;
		return
	is_day = false;
	for child in get_children():
		if child.is_in_group("enemy"):
			return
	#play here the game over message ( winning )
	_on_game_over()
	#canvas.color = DAY_COLOR_STUFF.lerp(NIGHT_COLOR_STUFF, abs(sin(time)))

func _on_game_over() -> void:
	#add timeout if needed
	%PopUpDeath.visible = true
	#get_tree().reload_current_scene();

func music_change(demon_mode:bool):
	if demon_mode:
		%AudioFx.stream = load("res://assets/sound/demon-theme.mp3")
		%AudioFx.playing = true
		return
	%AudioFx.stream = load("res://assets/sound/retro-games.mp3")
	%AudioFx.playing = true


func _on_restart_pressed():
	get_tree().reload_current_scene();


func _on_quit_pressed():
	get_tree().quit();


func _on_esc_quit_pressed():
	get_tree().quit();

func _on_esc_options_pressed():
	$CanvasLayer/Esc.visible = false
	$CanvasLayer/Options.visible = true


func _on_resume_pressed():
	get_tree().paused = false
	$CanvasLayer/Esc.visible = false



func _on_back_pressed():
	$CanvasLayer/Options.visible = false
	$CanvasLayer/Esc.visible = true
	
