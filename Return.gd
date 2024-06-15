extends State
var direction : Vector2

@export var idle_state: State
@export var stalk_state : State
@export var hit_state : State
@export var wall_climb_state : State


func enter() -> void:
	var distance: Vector2 = character.initial_position - character.global_position
	direction = distance.normalized()
	super()


func process_physics(delta: float) -> State:
	if character.is_hit:
		return hit_state
	var threshold: float = 1.0
	if abs(character.global_position.x - character.initial_position.x) < threshold:
		return idle_state
	if character.following_player and !%CeilingRay.is_colliding():
		return stalk_state
	if %WallRayCast.is_colliding() and !%CeilingRay.is_colliding():
		return wall_climb_state
	character.velocity.y += character.PLAYER_GRAVITY * delta
	character.velocity.x = character.SPEED * direction.x
	character.move_and_slide()
	return null
