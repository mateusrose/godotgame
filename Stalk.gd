extends State
var direction = 1

@export var idle_state: State
@export var return_state: State
@export var attack_state : State
@export var hit_state : State

func enter()-> void:
	super()
	
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta:float)-> State:
	if character.is_hit:
		return hit_state
	if character.player == null:
		return return_state
	var distance: Vector2 = character.player.global_position - character.global_position
	if abs(character.player.global_position.x - character.global_position.x) < 10:
		return attack_state
	var direction: Vector2 = distance.normalized()
	character.velocity.y += character.PLAYER_GRAVITY * delta
	if !%FloorRay.is_colliding():
		return null
	character.velocity.x = character.SPEED * direction.x
	character.move_and_slide()
	return null
	
func exit():
	character.following_player = false


func _on_follow_area_body_entered(body:Player_Character):
		character.player = body
	

func _on_vision_area_body_entered(body):
	var area = body.get_node("Hitbox")
	if area.is_in_group("player_hitbox"):
		character.player = body
		character.following_player = true

func _on_vision_area_body_exited(body):
	if !character.following_player:
		character.player = null


func _on_follow_area_body_exited(body):
	character.following_player = false
	character.player = null
