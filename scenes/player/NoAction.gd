extends State

@export var attack_state : State
@export var dash_state : State
@export var demon_state : State
@export var attack_area : Area2D

func enter()-> void:
	return
	
func process_physics(delta:float)-> State:
	attack_area.get_node("Collision").set_deferred("disabled", true)
	if Input.is_action_just_pressed("dash") and %Stamina.get_stamina() >= 10:
			return dash_state
	if Input.is_action_just_pressed("attack") and %Stamina.get_stamina() >= 5:
			return attack_state
	if Input.is_action_just_pressed("demon") and not demon_state.demon_mode and character.velocity == Vector2.ZERO:
		return demon_state
	return null
