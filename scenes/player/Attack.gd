extends State

var anim_ended = false
@export var no_action_state : State
@onready var attack_timer : Timer = $AttackTimer

func enter()-> void:
	animation.play("attack"+character.suffix)
	attack_timer.start()
	character.SPEED /= 3

func process_frame(delta:float):
	if anim_ended:
		if character.is_on_floor():
			if character.velocity.x == 0 :
				animation.play("idle")
			else:
				animation.play("run")
		else:
			animation.play("falling")
		return no_action_state
	return null

func exit():
	character.SPEED *= 3
	anim_ended = false

func _on_timer_timeout():
	anim_ended = true
