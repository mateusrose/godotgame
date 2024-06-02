extends CharacterBody2D
class_name Player

@onready var player_sprite: Sprite2D = $Sprite

@export var speed: int
var jump_count: int = 0
var landing: bool = false
@export var jump_speed: int
@export var player_gravity: int
var is_attacking : bool = false 
var is_blocking : bool = false
var is_crouching : bool = false
var can_track_input : bool = true;



func _physics_process(delta: float):
	horizontal_movement_env()
	vertical_movement_env()
	actions_env()
	move_and_slide()
	gravity(delta)
	player_sprite.animate(velocity)
		
func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if not can_track_input or is_attacking:
		velocity.x = 0
		return
		
	velocity.x = input_direction * speed

func vertical_movement_env():
	if is_on_floor():
		jump_count = 0
	var jump_condition = can_track_input and not is_attacking
	if Input.is_action_just_pressed("ui_select") and jump_count < 2 and jump_condition:
		jump_count += 1
		velocity.y = jump_speed

func gravity(delta:float) -> void:
	velocity.y += delta*player_gravity
	if velocity.y >= player_gravity:
		velocity.y = player_gravity

func actions_env() -> void :
	attack()
	crouch()
	block()
	
func attack() -> void :
	var attack_condition: bool = not is_attacking and not is_crouching and not is_blocking
	if Input.is_action_just_pressed("attack") and attack_condition and is_on_floor():
		is_attacking = true
		player_sprite.normal_attack = true
		
func crouch() -> void :
	if Input.is_action_pressed("crouch") and is_on_floor() and not is_blocking:
		is_crouching = true
		can_track_input = false
	elif not is_blocking:
		is_crouching = false
		can_track_input = true
		player_sprite.crouching_off = true
			
	
func block() -> void :
	if Input.is_action_pressed("block") and is_on_floor() and not is_crouching:
		is_blocking = true
		can_track_input = false
	elif not is_crouching:
		is_blocking = false
		can_track_input = true
		player_sprite.shield_off = true
	
