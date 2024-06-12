extends State

var anim_ended = false
@export var no_action_state : State
@export var dash_state : State
@export var demon_state : State
@onready var attack_timer : Timer = $AttackTimer
@export var attack_special_animation : AnimationPlayer
@export var attack_area : Area2D

func enter()-> void:
	%Stamina.change("decrease", 5)
	animation.play("attack"+character.suffix)
	if dash_state.just_dashed or demon_state.demon_mode:
		attack_special_animation.play("attack_dash")
		animation.speed_scale = 3
		attack_timer.wait_time = 0.277
	else:
		animation.speed_scale = 1.5
		attack_timer.wait_time = 0.533
	attack_timer.start()
	character.SPEED /= 3

func process_physics(delta:float):
	if anim_ended:
		if character.is_on_floor():
			if character.velocity.x == 0 :
				if character.is_crouched:
					animation.play("crouch")
				else:
					animation.play("idle")
			else:
				if character.is_crouched:
					animation.play("crouch_walk")
				else:
					animation.play("run")
		else:
			animation.play("falling")
		return no_action_state
	return null

func exit():
	character.SPEED *= 3
	animation.speed_scale = 1
	anim_ended = false
	attack_special_animation.play("RESET")
	

func _on_timer_timeout():
	%Dash.just_dashed = false
	anim_ended = true
	
func _on_attack_area_area_entered(area):
	if area.is_in_group("enemy_hitbox"):
		var health = area.get_parent().get_node("Health")
		if !area.get_parent().following_player:
			health.change("decrease", health.max_health)
			return
		health.change("decrease", %Damage.get_damage())
