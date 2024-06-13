extends CharacterBody2D

var PLAYER_GRAVITY = 350
@export var SPEED : int
var following_player = false
var is_hit = false
var is_dead = false
@export var sprite : Sprite2D
@onready var sound_area = $SoundArea
@onready var vision_area = $VisionArea
@onready var attack_area = $EnemyAttackArea
var player : Player_Character = null
@onready var initial_position = get_position()
@export var can_move : bool
@export var movement_state_machine : Node
var has_lost_player = false
var is_returning = false

func _ready():
	movement_state_machine.init()
	
func _unhandled_input(event:InputEvent):
	movement_state_machine.process_input(event)
	
func _physics_process(delta:float):
	movement_state_machine.process_physics(delta)
	verify_position(velocity)

func _process(delta:float):
	movement_state_machine.process_frame(delta)

func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		sound_area.position.x = 10
		vision_area.position.x = 60
		attack_area.position.x=18
		%FloorRay.target_position.x = 30
		$WallRayCast.target_position.x = 15
		%JumpingDownRay.target_position = Vector2(55,75)
		sprite.flip_h = false
	elif direction.x < 0:
		sound_area.position.x = -10
		vision_area.position.x = -60
		attack_area.position.x=-18
		$WallRayCast.target_position.x = -15
		%FloorRay.target_position.x = -30
		%JumpingDownRay.target_position = Vector2(-55,75)
		
		sprite.flip_h = true


