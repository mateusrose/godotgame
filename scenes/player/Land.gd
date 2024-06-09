extends State

@export var jump_state: State
@export var idle_state : State
@export var run_state : State
@export var crouch_state : State
@export var crouch_walk_state : State
var landing = false
@onready var land_timer: Timer = $LandTimer

func enter():
	landing = true
	super()
	jump_state.reset_jumps()
	land_timer.start()

	
func process_physics(delta:float) -> State:
	character.velocity.x = 0
	if !landing:
		if Input.is_action_pressed("crouch"):
			if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right"):
				return crouch_walk_state
			return crouch_state
		elif Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right"):
			return run_state
		return idle_state
	return null
	
func exit():
	landing = false

func _on_animation_animation_finished(anim_name):
	match anim_name:
		"landing":
			landing = false

#the timer ensures we leave landing state
func _on_land_timer_timeout():
	landing = false
