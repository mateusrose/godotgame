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
@onready var movement_state_machine = $MovementState
@onready var action_state_machine = $ActionState
@onready var sprite = $Sprite
@onready var wall_ray = $WallRay

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
		sprite.flip_h = false
		suffix = "_right"
		sprite.position = Vector2.ZERO
		wall_ray.target_position=Vector2(7, 0)
	elif direction.x < 0:
		sprite.flip_h = true
		suffix = "_left"
		sprite.position = Vector2(-2,0)
		wall_ray.target_position=Vector2(-9 , 0)
