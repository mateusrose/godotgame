extends State

@export var attack_state : State
@export var dash_state : State
@export var demon_state : State

func enter()-> void:
	return
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("dash"):
		return dash_state
	if Input.is_action_just_pressed("attack"):
		return attack_state
	if Input.is_action_just_pressed("demon"):
		return demon_state
	return
