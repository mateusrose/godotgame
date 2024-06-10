extends State
var direction : Vector2

@export var idle_state: State
@export var stalk_state : State
@export var hit_state : State


func enter() -> void:
	var distance: Vector2 = character.initial_position - character.global_position
	direction = distance.normalized()
	super()
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if character.is_hit:
		return hit_state
	var threshold: float = 1.0
	if abs(character.global_position.x - character.initial_position.x) < threshold:
		return idle_state
	if character.following_player:
		return stalk_state
	character.velocity.y += character.PLAYER_GRAVITY * delta
	character.velocity.x = character.SPEED * direction.x
	character.move_and_slide()
	return null
