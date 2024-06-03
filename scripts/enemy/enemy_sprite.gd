extends Sprite2D
class_name EnemySprite

@export var animation_path:NodePath 
@onready var animation:AnimationPlayer = get_node(animation_path)

@export var enemy_path: NodePath
@onready var enemy : CharacterBody2D = get_node(enemy_path)

@export var attack_area_collision_path: NodePath
@onready var attack_area_collision : CollisionShape2D  = get_node(attack_area_collision_path)

func animate(velocity: Vector2)->void:
	pass

func _on_animation_finished(_anim_name: String):
	pass # Replace with function body.
