extends State

@export var fall_state: State
@export var jump_state : State
@export var run_state : State
@export var crouch_state: State
@export var hit_state: State
var anim_can_play = true

func enter()-> void:
	%SoundArea.set_deferred("disabled", true)
	if _get_anim():
		super()
	character.velocity.x = 0
	
	
func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and character.is_on_floor():
		return jump_state
	if Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right") or Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		return run_state
	if Input.is_action_pressed("crouch"):
		return crouch_state
	return null

func process_physics(delta:float)-> State:
	
	if get_parent().is_hit:
		return hit_state
	character.velocity.y += character.PLAYER_GRAVITY * delta * character.MULTIPLIER
	character.move_and_slide()
	if !character.is_on_floor():
		return fall_state
	return null

func exit():
	if %Attack.anim_ended:
		anim_can_play = true
	%SoundArea.set_deferred("disabled", false)
	%Crouch.crouch_multiplier = 1.5

func _on_attack_cant_fall():
	anim_can_play = false
	#animation.play("idle")
	
func _get_anim()->bool:
	return anim_can_play
