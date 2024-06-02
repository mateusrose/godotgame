extends Sprite2D
class_name Sprite

@export var animation_path: NodePath
@onready var animation : AnimationPlayer = get_node(animation_path)
@export var player_path: NodePath
@onready var player: CharacterBody2D = get_node(player_path)


func _ready() -> void:
# Check if the nodes are valid
	if animation and player:
		print("AnimationPlayer and CharacterBody2D nodes found.")
		animation.animation_finished.connect(_on_animation_finished)
		print("Connected animation_finished signal.")
	else:
		print("Error: Nodes not found. Check paths.")

func animate(direction: Vector2) -> void:
	verify_position(direction)
	
	if  direction.y < 5.83333349225 || direction.y > 5.833334:
		vertical_behaviour(direction)
	elif player.landing:
		player.set_physics_process(false)
		animation.play("landing")
	else:
		print(direction.y)
		horizontal_behaviour(direction)
	
func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
	elif direction.x < 0:
		flip_h = true
		
func vertical_behaviour(direction: Vector2) -> void:
	if direction.y > 6:
		animation.play("fall")
		player.landing = true
	elif direction.y < 6:
		animation.play("jump")

func horizontal_behaviour(direction: Vector2) -> void:
	if direction.x != 0:
		animation.play("run")
	else:
		animation.play("idle")

func _on_animation_finished(anim_name: String):
	match anim_name:
		"landing":
			player.landing = false
			player.set_physics_process(true)
