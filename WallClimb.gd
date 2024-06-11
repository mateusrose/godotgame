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
		character.velocity.y = -130
	
	else:
		print("else")
		climb_ended = true
		if character.following_player:
			print("stalk")
			return stalk_state
		character.velocity.y += character.PLAYER_GRAVITY * delta
		if %FloorRay.target_position.x > 0:
			print("x > 0")
			character.velocity.x = character.SPEED
		else:
			print("x < 0")
			character.velocity.x = -character.SPEED
		
	character.move_and_slide()
	return null


