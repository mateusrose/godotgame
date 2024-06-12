extends State
var direction = 1

@export var idle_state: State
@export var return_state: State
@export var attack_state : State
@export var hit_state : State
@export var wall_climb_state : State
@export var stalk_state: State
var following_player_middleware : bool = false

func enter()-> void:
	following_player_middleware = false
	super()
	
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta:float)-> State:
	if character.is_hit:
		return hit_state
	if character.player == null:
		return return_state
	if character.following_player:
		following_player_middleware = true
	if %WallRayCast.is_colliding():
		following_player_middleware = true
		return wall_climb_state
	var distance: Vector2 = character.player.global_position - character.global_position
	if abs(character.player.global_position.x - character.global_position.x) < 10:
		return attack_state
	var direction: Vector2 = distance.normalized()
	
	character.velocity.y += character.PLAYER_GRAVITY * delta
	
	
	character.velocity.x = character.SPEED * direction.x
	character.move_and_slide()
	return null
	
func exit():
	character.following_player = following_player_middleware


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


func _on_sound_area_area_entered(area):
	if area.is_in_group("player_sound_area"):
		character.player = area.get_parent()
		character.following_player = true


func _on_sound_area_area_exited(area):
	if !character.following_player:
		character.player = null
