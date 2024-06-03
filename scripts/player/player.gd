extends CharacterBody2D
class_name Player

@onready var player_sprite: Sprite2D = $Sprite
@onready var wall_ray: RayCast2D = $WallRay
@onready var stats: Node = $Stats
@export var speed: int
var jump_count: int = 0
var direction: int = 1
var landing: bool = false
@export var jump_speed: int
@export var player_gravity: int
var is_attacking : bool = false 
var is_blocking : bool = false
var is_crouching : bool = false
var can_track_input : bool = true
var on_wall: bool = false
var not_on_wall: bool = true
@export var wall_jump_speed: int
@export var wall_gravity: int
@export var wall_impulse_speed: int
var on_hit: bool = false
var dead:bool = false



func _physics_process(delta: float):
	print("banana")
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
	if is_on_floor() or is_on_wall():
		jump_count = 0
		
	var jump_condition = can_track_input and not is_attacking
	if Input.is_action_just_pressed("ui_select") and jump_count < 2 and jump_condition:
		jump_count += 1
		if next_to_wall() and not is_on_floor():
			velocity.y = wall_jump_speed
			velocity.x = wall_impulse_speed * direction
		else:
			velocity.y = jump_speed

func gravity(delta:float) -> void:
	if next_to_wall():
		velocity.y += wall_gravity * delta
		if velocity.y >= wall_gravity:
			velocity.y = wall_gravity
	velocity.y += delta*player_gravity
	if velocity.y >= player_gravity:
		velocity.y = player_gravity

func next_to_wall()-> bool:
	if wall_ray.is_colliding() and not is_on_floor():
		if not_on_wall:
			velocity.y = 0
			not_on_wall = false
		return true
	else:
		not_on_wall = true
		return false

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
		stats.blocking = false
		can_track_input = false
	elif not is_blocking:
		is_crouching = false
		can_track_input = true
		stats.blocking = false
		player_sprite.crouching_off = true
	
func block() -> void :
	if Input.is_action_pressed("block") and is_on_floor() and not is_crouching:
		is_blocking = true
		stats.blocking = true
		can_track_input = false
	elif not is_crouching:
		is_blocking = false
		stats.blocking = false
		can_track_input = true
		player_sprite.shield_off = true
	
