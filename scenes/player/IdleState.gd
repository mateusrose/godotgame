extends State

@export var fall_state: State
@export var jump_state : State
@export var run_state : State
@export var crouch_state: State
@export var hit_state: State

func enter()-> void:
	super()
	character.velocity.x = 0
	
	
func process_input(event: InputEvent) -> State:
	if get_parent().is_hit:
		return hit_state
	if Input.is_action_just_pressed("jump") and character.is_on_floor():
		return jump_state
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		return run_state
	if Input.is_action_pressed("crouch"):
		return crouch_state
	return null

func process_physics(delta:float)-> State:
	character.velocity.y += character.PLAYER_GRAVITY * delta * character.MULTIPLIER
	character.move_and_slide()
	if !character.is_on_floor():
		return fall_state
	return null
