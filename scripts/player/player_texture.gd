extends Sprite2D
class_name Sprite

@export var animation_path: NodePath
@onready var animation : AnimationPlayer = get_node(animation_path)
@export var player_path: NodePath
@onready var player: CharacterBody2D = get_node(player_path)
var normal_attack:bool = false;
var shield_off: bool = false
var crouching_off:bool = false
var suffix:String = "_right"

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
	
	if player.is_attacking or player.is_blocking or player.is_crouching:
		print(player.is_blocking)
		action_behaviour()
	elif  direction.y < 5.83333349225 || direction.y > 5.833334:
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
		suffix = "_right"
	elif direction.x < 0:
		flip_h = true
		suffix = "_left"
		
func action_behaviour() -> void:
	
	if player.is_attacking == true and normal_attack:
		print("bananas")
		animation.play("attack" + suffix)
	elif player.is_blocking and shield_off:
		animation.play("block")
		shield_off = false
	elif player.is_crouching and crouching_off:
		animation.play("crouch")
		crouching_off = false
		

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
		"attack_left":
			normal_attack = false
			player.is_attacking = false
		"attack_right":
			player.is_attacking = false
			normal_attack = false
