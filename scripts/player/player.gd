extends CharacterBody2D
class_name Player

@onready var player_sprite: Sprite2D = $Sprite

@export var speed: int
var jump_count: int = 0
var landing: bool = false
@export var jump_speed: int
@export var player_gravity: int
var attacking : bool = false 
var blocking : bool = false
var crouching : bool = false
var can_track_input : bool = true;



func _physics_process(delta: float):
	horizontal_movement_env()
	vertical_movement_env()
	move_and_slide()
	gravity(delta)
	player_sprite.animate(velocity)
		
func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = input_direction * speed

func vertical_movement_env():
	if is_on_floor():
		jump_count = 0
	if Input.is_action_just_pressed("ui_select") and jump_count < 2:
		jump_count += 1
		velocity.y = jump_speed

func gravity(delta:float) -> void:
	velocity.y += delta*player_gravity
	if velocity.y >= player_gravity:
		velocity.y = player_gravity

