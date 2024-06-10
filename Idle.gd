extends State
@onready var timer = $IdleTimer
var done_idle = false
@export var wander_state: State
@export var stalk_state : State
@export var hit_state : State

func enter()-> void:
	super()
	done_idle = false
	character.velocity.x = 0
	timer.start()
	
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta:float)-> State:
	if character.is_hit:
		return hit_state
	if done_idle:
		return wander_state
	elif character.following_player:
		return stalk_state
	character.velocity.y += character.PLAYER_GRAVITY * delta
	character.move_and_slide()
	return null

func exit():
	done_idle = false

func _on_idle_timer_timeout():
	done_idle = true
