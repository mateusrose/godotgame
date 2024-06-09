extends State

@export var idle_state : State
@export var run_state : State
@export var jump_state : State
@export var land_state : State
@export var wall_slide_state : State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	return null

func process_physics(delta:float) -> State:
	character.velocity.y += character.PLAYER_GRAVITY * delta * character.MULTIPLIER
	var movement = Input.get_axis("move_left","move_right") * character.SPEED
	if movement != 0:
		sprite.flip_h = (movement < 0)
	character.velocity.x = movement
	character.move_and_slide()
	if character.is_on_floor():
		return land_state
	if wall_slide_state.next_to_wall():
		return wall_slide_state
	return null
