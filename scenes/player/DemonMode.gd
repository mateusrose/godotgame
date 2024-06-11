extends State

var anim_ended = false
var demon_mode = false
@export var no_action_state : State
@onready var demon_timer = $DemonTimer
@onready var anim_timer = $AnimTime
@export var demon_animation: AnimationPlayer
@export var crouch_state: State

func enter()-> void:
	super()
	change_stats(true)
	demon_timer.start()
	anim_timer.start()
	

func process_frame(delta:float):
	character.velocity = Vector2.ZERO
	if anim_ended:
		return no_action_state
	return null

func change_stats(status:bool):
	if status:
		character.MULTIPLIER = 4
		character.PLAYER_GRAVITY = 225
		character.JUMP_SPEED = -350
		character.DASH_SPEED = 2
		demon_mode = true
		demon_animation.play("demon_power")
		return
	character.MULTIPLIER = 1
	character.PLAYER_GRAVITY = 350
	character.JUMP_SPEED = -175
	character.DASH_SPEED = 5
	demon_mode = false
	demon_animation.play("RESET")

func _on_demon_timer_timeout():
	change_stats(false)

func _on_anim_time_timeout():
	anim_ended = true
	if character.velocity.x != 0:
		animation.play("run")
	animation.play("idle")
