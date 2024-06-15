extends State

var hit_ended = false
@export var fall_state: State
@export var jump_state : State
@export var run_state : State
@export var crouch_state: State
@export var crouch_walk_state: State
@export var idle_state: State
@export var death_state: State


func enter():
	super()
	get_parent().is_hit = true
	hit_ended = false
	$HitTimer.start()
	$HitAnimTimer.start()

func process_physics(_delta: float) -> State:
	if hit_ended:
		if %Health.is_dead():
			return death_state
		if character.is_on_floor():
			if character.velocity.x == 0 :
				if character.is_crouched:
					return crouch_state
				else:
					return idle_state
			else:
				if character.is_crouched:
					return crouch_walk_state
				else:
					return run_state
		else:
			return fall_state
	return null
	
	
func _on_animation_animation_finished(anim_name):
	match anim_name:
		"hit":
			hit_ended = true
			
func _on_health_health_hit():
	get_parent().is_hit = true
	%CollisionArea.set_deferred("monitorable", false)
	#hit_ended = true

func _on_hit_timer_timeout():
	%CollisionArea.set_deferred("monitorable", true)
	
func _on_hit_anim_timer_timeout():
	get_parent().is_hit = false
	hit_ended = true
