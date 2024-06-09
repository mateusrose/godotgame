extends State

@export var fall_state: State
@export var jump_state : State
@export var run_state : State
@export var idle_state: State
@export var crouch_walk_state : State
var crouch_multiplier = 1.5

func enter()-> void:
	super()
	character.velocity.x = 0
	
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed("crouch"):
		if Input.is_action_just_pressed("jump") and character.is_on_floor():
			character.JUMP_SPEED *= crouch_multiplier
			return jump_state
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			return crouch_walk_state
		return null
	if character.velocity.x != 0:
		return run_state
	return idle_state

func process_physics(delta:float)-> State:
	character.velocity.y += character.PLAYER_GRAVITY * delta * character.MULTIPLIER
	character.move_and_slide()
	if !character.is_on_floor():
		return fall_state
	return null
