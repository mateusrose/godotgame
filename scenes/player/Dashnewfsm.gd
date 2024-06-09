extends State

var anim_ended = false
@export var no_action_state : State
@onready var dash_timer : Timer = $DashTimer

func enter()-> void:
	super()
	dash_timer.start()

func process_physics(delta:float)-> State:
	var movement = Input.get_axis("move_left","move_right") * character.SPEED * character.MULTIPLIER * character.DASH_SPEED
	sprite.flip_h = movement < 0
	character.velocity.x = movement
	character.move_and_slide()
	
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
	anim_ended = false


func _on_dash_timer_timeout():
	anim_ended = true
