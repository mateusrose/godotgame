extends Area2D
class_name DetectionArea

@export var enemy_path:NodePath 
@onready var enemy:CharacterBody2D = get_node(enemy_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(enemy)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body: Player) -> void:
	enemy.player_ref = body
	pass # Replace with function body.


func _on_body_exited(body: Player) -> void:
	enemy.player_ref = null
	pass # Replace with function body.
