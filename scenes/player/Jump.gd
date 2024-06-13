extends State

@export var fall_state: State
@export var idle_state: State
@export var run_state: State
@export var jump_state : State
@export var crouch_state : State
@export var hit_state: State

var max_jumps = 2
var current_jumps = 0


func enter() -> void:
	%Crouch.crouch_multiplier = 1
	if current_jumps < max_jumps:
		%SoundArea.set_deferred("disabled", true)
		super()
		character.velocity.y = character.JUMP_SPEED
		current_jumps += 1
		#fixing crouch jump, kinda hardcoded
	if character.JUMP_SPEED < -400:
		character.JUMP_SPEED = -350
	if character.JUMP_SPEED > -300:
		character.JUMP_SPEED = -175

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	return null

func process_physics(delta:float) -> State:
	if get_parent().is_hit:
		return hit_state
	character.velocity.y += character.PLAYER_GRAVITY * delta * character.MULTIPLIER
	if character.velocity.y > 0:
		return fall_state
	var movement = Input.get_axis("move_left","move_right") * character.SPEED * character.MULTIPLIER
	if movement != 0:
		sprite.flip_h = movement < 0
	character.velocity.x = movement
	character.move_and_slide()
	
	if character.is_on_floor():
		if movement != 0:
			return run_state
		return idle_state
	return null
	
func exit():
	%SoundArea.set_deferred("disabled", false)
	%Crouch.crouch_multiplier = 1
	
func reset_jumps():
	current_jumps = 0
