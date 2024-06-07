extends Sprite2D
class_name Sprite

@export var animation_path: NodePath
@onready var animation : AnimationPlayer = get_node(animation_path)
@export var player_path: NodePath
@onready var player: CharacterBody2D = get_node(player_path)
@export var attack_collision_path : NodePath
@onready var attack_collision : CollisionShape2D = get_node(attack_collision_path)
var normal_attack:bool = false;
var shield_off: bool = false
var crouching_off:bool = false
var suffix:String = "_right"
var current_position: int
var is_crouched: bool
signal game_over

func _ready() -> void:
# Check if the nodes are valid
	if animation and player:
		animation.animation_finished.connect(_on_animation_finished)
	else:
		print("Error: Nodes not found. Check paths.")

func _process(delta)-> void:
	if Input.is_action_just_released("crouch"):
		is_crouched = false

func animate(direction: Vector2) -> void:
	if player.dashing:
		animation.play("dash")
		return
	verify_position(direction)
	if player.on_hit or player.dead:
		hit_behaviour()
	elif player.is_attacking or player.is_blocking or player.is_crouching or player.next_to_wall():
		action_behaviour()
	elif  direction.y < 5.83333349225 || direction.y > 5.833334:
		vertical_behaviour(direction)
	elif player.landing:
		player.set_physics_process(false)
		animation.play("landing")
	else:
		horizontal_behaviour(direction)

func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
		suffix = "_right"
		player.direction = -1
		position = Vector2.ZERO
		player.wall_ray.target_position=Vector2(11, 0)
	elif direction.x < 0:
		flip_h = true
		suffix = "_left"
		player.direction = 1
		position = Vector2(-2,0)
		player.wall_ray.target_position=Vector2(-13 , 0)
		
func hit_behaviour() -> void:
	player.set_physics_process(false)
	attack_collision.set_deferred("disabled", true)
	if player.dead:
		animation.play("dead")
	elif player.on_hit:
		animation.play("hit")


func action_behaviour() -> void:
	if player.next_to_wall():
		animation.play("wall_slide")
	elif player.is_attacking == true and normal_attack:
		animation.play("attack" + suffix)
	elif player.is_blocking and shield_off:
		animation.play("block")
		shield_off = false
	elif player.is_crouching:
		if player.velocity.x == 0 and is_crouched:
			animation.play("crouched")
		elif player.velocity.x == 0 and not is_crouched:
			print("i am crouching")
			animation.play("crouch")
			is_crouched = true
		else:
			print("i am crouch walking")
			animation.play("idle")
		#crouching_off = false
		

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
		if player.is_crouching:
			animation.play("crouch")
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
		"hit":
			player.on_hit = false
			player.set_physics_process(true)
			if player.is_blocking:
				animation.play("block")
			if player.is_crouching:
				animation.play("crouch")	
		"dead":
			emit_signal("game_over")
		"idle":
			if(player.velocity.x != 0):
				is_crouched = false
		"crouched":
			if(player.velocity.x != 0):
				is_crouched = false
