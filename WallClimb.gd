extends State

@export var wander_state: State
@export var stalk_state: State
@export var hit_state : State
@export var return_state : State
var climb_ended = false

func enter():
	climb_ended = false


func process_physics(delta:float)-> State:
	if %CeilingRay.is_colliding():
			return return_state
	if climb_ended:
		return wander_state
	if %WallRayCast.is_colliding():
		character.velocity.y = -130
	else:
		climb_ended = true
		if character.following_player and not %CeilingRay.is_colliding():
			return stalk_state
		character.velocity.y += character.PLAYER_GRAVITY * delta
		if %FloorRay.target_position.x > 0:
			character.velocity.x = character.SPEED
		else:
			character.velocity.x = -character.SPEED
		
	character.move_and_slide()
	return null


