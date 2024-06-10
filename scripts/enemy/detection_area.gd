extends Area2D
class_name DetectionArea

@export var enemy_path:NodePath 
@onready var enemy:CharacterBody2D = get_node(enemy_path)

func _on_body_entered(body: Player_Character) -> void:
	enemy.player_ref = body

func _on_body_exited(body: Player_Character) -> void:
	enemy.player_ref = null
