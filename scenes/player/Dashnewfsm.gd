extends State

var just_dashed = false
var anim_ended = false
@export var no_action_state : State
@export var wall_slide_state : State
@onready var dash_timer : Timer = $DashTimer
@onready var just_dashed_timer : Timer = $JustDashedTimer

func enter()-> void:
	%Stamina.change("decrease", 10)
	super()
	%Health.can_take_damage = false
	dash_timer.start()
	just_dashed_timer.start()
	just_dashed = true
	
	if %WallTeleporterClose.is_colliding() and !%WallTeleporterCheck.is_colliding() and !%WallTeleporterBack.is_colliding():
		if %WallTeleporterClose2.is_colliding() and !%WallTeleporterCheck2.is_colliding() and !%WallTeleporterBack2.is_colliding():
			if %WallTeleporterThin.is_colliding():
				character.global_position.x = %WallTeleporterCheck.global_position.x
		

func process_physics(_delta:float)-> State:
	var movement = Input.get_axis("move_left","move_right") * character.SPEED * character.MULTIPLIER * character.DASH_SPEED
	character.velocity.x = movement
	character.move_and_slide()
	
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
			if character.next_to_wall():
				animation.play("wall_slide")
			animation.play("fall")
		return no_action_state
	return null

func exit():
	anim_ended = false


func _on_dash_timer_timeout():
	%Health.can_take_damage = true
	anim_ended = true

func _on_just_dashed_timer_timeout():
	just_dashed = false
