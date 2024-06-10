extends State
var hit_ended = false
@export var stalk_state : State
@export var kill_state : State

func enter():
	super()
	character.is_hit = false
	hit_ended = false

func process_physics(delta: float) -> State:
	if hit_ended:
		if character.is_dead:
			return kill_state
		return stalk_state
	return null
	
func _on_health_health_hit():
	character.is_hit = true
	

func _on_animation_finished(anim_name):
	match anim_name:
		"hit":
			hit_ended = true
			character.following_player = true
			


func _on_health_health_depleted():
	character.is_dead = true
