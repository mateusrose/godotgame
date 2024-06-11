extends State

@export var fall_state: State
@export var jump_state : State
@export var idle_state : State
@export var crouch_state: State
@export var hit_state: State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and character.is_on_floor():
		return jump_state
	if Input.is_action_pressed("crouch"):
		return crouch_state
	
	return null

func process_physics(delta:float)-> State:
	if get_parent().is_hit:
		return hit_state
	character.velocity.y += character.PLAYER_GRAVITY * character.MULTIPLIER
	var movement = Input.get_axis("move_left","move_right") * character.SPEED * character.MULTIPLIER
	if movement == 0:
		return idle_state
		
	sprite.flip_h = movement < 0
	character.velocity.x = movement
	character.move_and_slide()
	
	if !character.is_on_floor():
		return fall_state
	return null

func exit():
	%Crouch.crouch_multiplier = 1.5
