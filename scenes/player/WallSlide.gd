extends State
@export var wall_ray : RayCast2D
var on_wall = false
@export var wall_gravity: int
@export var fall_state: State
@export var jump_state : State
@export var hit_state: State

func enter():
	super()
	%SoundArea.set_deferred("disabled", true)
	

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return fall_state
	return null

func process_physics(delta:float) -> State:
	if get_parent().is_hit:
		return hit_state
	if next_to_wall():
		jump_state.reset_jumps()
		character.velocity.y += wall_gravity * delta
		if character.velocity.y > wall_gravity:
			character.velocity.y = wall_gravity
	else:
		character.velocity.y += wall_gravity * delta
		return fall_state
	character.move_and_slide()
	return null
	
func exit():
	%SoundArea.set_deferred("disabled", false)
func next_to_wall()-> bool:
	if wall_ray.is_colliding() and not character.is_on_floor():
		if not on_wall:
			on_wall = true
			character.velocity.y = 0
		return true
	else:
		on_wall = false
		return false
