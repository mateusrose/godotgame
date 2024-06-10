extends State

@export var return_state: State
@export var stalk_state : State
@export var hit_state : State
var attack_ended = false


func enter() -> void:
	super()
	attack_ended = false
	
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if character.is_hit:
		return hit_state
	if attack_ended:
		return stalk_state
	return null


func _on_animation_animation_finished(anim_name):
	attack_ended = true


func _on_enemy_attack_area_area_entered(area):
	if area.is_in_group("player_hitbox"):
		area.get_parent().get_node("Health").change("decrease", %Damage.get_damage())
