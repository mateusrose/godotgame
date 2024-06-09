extends State

@export var fall_state: State
@export var jump_state : State
@export var run_state : State
@export var idle_state: State
@export var crouch_state: State

	
func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed("crouch"):
		if Input.is_action_just_pressed("jump") and character.is_on_floor():
			return jump_state
		return null
	if character.velocity.x != 0:
		return run_state
	return idle_state

func process_physics(delta:float)-> State:
	character.velocity.y += character.PLAYER_GRAVITY * delta * character.MULTIPLIER
	var movement = Input.get_axis("move_left","move_right") * ((character.SPEED)/2) * character.MULTIPLIER
	if movement == 0:
		return crouch_state
	sprite.flip_h = movement < 0
	character.velocity.x = movement
	character.move_and_slide()
	if !character.is_on_floor():
		return fall_state
	return null
