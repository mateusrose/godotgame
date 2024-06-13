extends State

@export var fall_state: State
@export var jump_state : State
@export var run_state : State
@export var idle_state: State
@export var crouch_state: State
@export var crouch_walk_state: State
@export var sound_area : Area2D
@export var hit_state: State
var anim_can_play = true


func enter():
	if anim_can_play:
		super()
	character.is_crouched = true
	sound_area.monitoring = false
	sound_area.get_node("SoundArea").set_deferred("disabled", true)
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed("crouch"):
		if Input.is_action_just_pressed("jump") and character.is_on_floor():
			character.JUMP_SPEED *= crouch_state.crouch_multiplier
			return jump_state
		return null
	if character.velocity.x != 0:
		return run_state
	return idle_state

func process_physics(delta:float)-> State:
	if get_parent().is_hit:
		return hit_state
	
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
	
func exit():
	anim_can_play = true
	character.is_crouched = false
	sound_area.monitoring = true
	sound_area.get_node("SoundArea").set_deferred("disabled", false)


func _on_attack_cant_fall():
	anim_can_play = false
