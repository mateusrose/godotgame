extends State

@export var fall_state: State
@export var jump_state : State
@export var run_state : State
@export var idle_state: State
@export var crouch_walk_state : State
var crouch_multiplier = 1.5
@export var sound_area : Area2D
var is_next_state_crouch = false

func enter()-> void:
	super()
	character.is_crouched = true
	sound_area.monitoring = false
	sound_area.get_node("SoundArea").set_deferred("disabled", true)
	character.velocity.x = 0
	
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed("crouch"):
		if Input.is_action_just_pressed("jump") and character.is_on_floor():
			character.JUMP_SPEED *= crouch_multiplier
			return jump_state
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left"):
			is_next_state_crouch = true
			return crouch_walk_state
		return null
	if character.velocity.x != 0:
		return run_state
	return idle_state
	
func exit():
	if is_next_state_crouch:
		is_next_state_crouch = false
		return
	sound_area.monitoring = true
	sound_area.get_node("SoundArea").set_deferred("disabled", false)
	is_next_state_crouch = false
	character.is_crouched = false
	

func process_physics(delta:float)-> State:
	character.velocity.y += character.PLAYER_GRAVITY * delta * character.MULTIPLIER
	character.move_and_slide()
	if !character.is_on_floor():
		return fall_state
	return null
