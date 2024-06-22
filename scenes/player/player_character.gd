extends CharacterBody2D
class_name Player_Character

var SPEED = 75
var JUMP_SPEED = -175
var DASH_SPEED = 5
var JUMP_COUNT = 1
var PLAYER_GRAVITY = 350
var CAN_TRACK_INPUT = true
var MULTIPLIER = 1
var suffix = "_right"
var is_crouched = false
@onready var movement_state_machine = $MovementState
@onready var action_state_machine = $ActionState
@onready var sprite = $Sprite
@onready var wall_ray = $WallRay
@onready var sprite_attack = $AttackSprite
@onready var sprite_demon = $DemonSprite
@export var stage : Node


func _ready():
	movement_state_machine.init()
	action_state_machine.init()
	
func _unhandled_input(event:InputEvent):
	movement_state_machine.process_input(event)
	action_state_machine.process_input(event)
	
func _physics_process(delta:float):
	verify_position(velocity)
	movement_state_machine.process_physics(delta)
	action_state_machine.process_physics(delta)
	
func _process(delta:float):
	movement_state_machine.process_frame(delta)
	action_state_machine.process_frame(delta)



#fixing vector position according to direction
func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		sprite_attack.flip_h = false
		sprite_demon.flip_h = false
		sprite.flip_h = false
		suffix = "_right"
		sprite.position = Vector2(2,0)
		wall_ray.target_position=Vector2(7, 0)
		%WallTeleporterClose.target_position = Vector2(95,0)
		%WallTeleporterCheck.target_position = Vector2(20,0)
		%WallTeleporterCheck.position.x = 95
		%WallTeleporterBack.target_position = Vector2(-20,0)
		%WallTeleporterBack.position.x = 115
		%WallTeleporterClose2.target_position = Vector2(95,0)
		%WallTeleporterCheck2.target_position = Vector2(20,0)
		%WallTeleporterCheck2.position.x = 95
		%WallTeleporterBack2.target_position = Vector2(-20,0)
		%WallTeleporterBack2.position.x = 115
		%WallTeleporterThin.target_position = Vector2(-25,0)
		%WallTeleporterThin.position.x = 25
	elif direction.x < 0:
		sprite_attack.flip_h = true
		sprite_demon.flip_h = true
		sprite.flip_h = true
		suffix = "_left"
		sprite.position = Vector2(-2,0)
		wall_ray.target_position=Vector2(-9 , 0)
		%WallTeleporterClose.target_position = Vector2(-95,0)
		%WallTeleporterCheck.target_position = Vector2(-20,0)
		%WallTeleporterCheck.position.x = -95
		%WallTeleporterBack.target_position = Vector2(20,0)
		%WallTeleporterBack.position.x = -115
		%WallTeleporterClose2.target_position = Vector2(-95,0)
		%WallTeleporterCheck2.target_position = Vector2(-20,0)
		%WallTeleporterCheck2.position.x = -95
		%WallTeleporterBack2.target_position = Vector2(20,0)
		%WallTeleporterBack2.position.x = -115
		%WallTeleporterThin.target_position = Vector2(25,0)
		%WallTeleporterThin.position.x = -25

func next_to_wall()-> bool:
	if %WallRay.is_colliding() and not is_on_floor():
		return true
	return false
