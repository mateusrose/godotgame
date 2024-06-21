extends State
var direction_new = 1

@export var idle_state: State
@export var return_state: State
@export var attack_state : State
@export var hit_state : State
@export var wall_climb_state : State
@export var stalk_state: State
var following_player_middleware : bool = false

func enter()-> void:
	print(character.following_player)
	following_player_middleware = false
	super()

func process_physics(delta:float)-> State:
	if character.is_hit:
		return hit_state
	if character.player == null or !%JumpingDownRay.is_colliding():
		return return_state
	if character.following_player:
		following_player_middleware = true
	if %WallRayCast.is_colliding():
		following_player_middleware = true
		return wall_climb_state
	var distance: Vector2 = character.player.global_position - character.global_position
	if abs(character.player.global_position.x - character.global_position.x) < 10:
		return attack_state
	direction_new = distance.normalized().x
	character.velocity.y += character.PLAYER_GRAVITY * delta
	character.velocity.x = character.SPEED * direction_new
	character.move_and_slide()
	return null
	
func exit():
	character.following_player = following_player_middleware


func _on_follow_area_body_entered(body:Player_Character):
	character.player = body
	

func _on_vision_area_body_entered(body:Player_Character):
	if not %WallRayCast.is_colliding():
		var area = body.get_node("Hitbox")
		if area == null:
			return
		if area.is_in_group("player_hitbox"):
			character.player = body
			character.following_player = true

func _on_vision_area_body_exited(body:Player_Character):
	if !character.following_player and body:
		character.player = null

func _on_follow_area_body_exited(body: Player_Character):
	if body:
		character.following_player = false
		character.player = null


func _on_sound_area_area_entered(area):
	if area.is_in_group("player_sound_area"):
		character.player = area.get_parent()
		character.following_player = true


func _on_sound_area_area_exited(area):
	if area.is_in_group("player_sound_area"):
		if !character.following_player:
			character.player = null
