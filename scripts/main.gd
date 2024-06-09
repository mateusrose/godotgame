extends Node2D
class_name Main
@onready var player: CharacterBody2D = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var _game_over: bool = player.get_node("Sprite").game_over.connect(_on_game_over)


func _on_game_over() -> void:
	var _reload: bool = get_tree().reload_current_scene()
