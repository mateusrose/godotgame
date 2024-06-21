extends CharacterBody2D
class_name EnemyNightborn

var PLAYER_GRAVITY = 350
@export var SPEED : int
var SPEED_DAY : int
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
@export var stage : Node
@export var items_dropable : Array[String]
var demon_mode = false

func _ready():
	SPEED_DAY = SPEED
	movement_state_machine.init()
	
func _unhandled_input(event:InputEvent):
	movement_state_machine.process_input(event)
	
func _physics_process(delta:float):
	if stage.is_day:
		SPEED = SPEED_DAY
		demon_mode = false
	elif demon_mode:
		pass
	elif !stage.is_day:
		SPEED_DAY = SPEED
		SPEED *= 2
		demon_mode = true
		
	movement_state_machine.process_physics(delta)
	verify_position(velocity)
	if following_player:
		$FollowingPlayer.visible = true
		return
	$FollowingPlayer.visible = false

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


