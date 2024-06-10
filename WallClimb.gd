extends State

@export var wander_state: State
@export var stalk_state: State
@export var hit_state : State
var climb_ended = false

func enter():
	climb_ended = false

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta:float)-> State:
	if climb_ended:
		return wander_state
	if %WallRayCast.is_colliding():
		character.velocity.y = -character.SPEED 
	elif %FloorRay.is_colliding() and not climb_ended:
		character.velocity.y = -character.SPEED - 20
	else:
		climb_ended = true
		character.velocity.y = 0
		if %FloorRay.target_position.x > 0:
			character.velocity.x = character.SPEED
		else:
			character.velocity.x = -character.SPEED
	character.move_and_slide()
	return null


