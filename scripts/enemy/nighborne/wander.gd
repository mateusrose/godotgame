extends State

@onready var timer = $WanderTimer
var new_direction = RandomNumberGenerator.new()
var direction = 1
var wander_done = false
@export var idle_state: State
@export var stalk_state: State
@export var hit_state : State
@export var wall_climb_state : State

func enter()-> void:
	wander_done = false
	if !character.can_move:
		animation.play("idle")
	else:
		super()
	if !%FloorRay.is_colliding():
		if %FloorRay.target_position.x > 0:
			direction = -1
		else:
			direction = 1
	else:
		set_direction()
	timer.start()
	
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta:float)-> State:
	if character.is_hit:
		return hit_state
	
		
	if %WallRayCast.is_colliding():
		return wall_climb_state
	if !%FloorRay.is_colliding():
		return idle_state
	character.velocity.y += character.PLAYER_GRAVITY * delta
	character.velocity.x = character.SPEED * direction
	
	if !character.can_move:
		character.velocity.x = 3*direction
		
	character.move_and_slide()
	if character.following_player:
		return stalk_state
	if wander_done:
		return idle_state
	return null

func set_direction():
	var dir = new_direction.randi_range(0,1)
	if dir == 0:
		direction = -1
		return
	direction = dir
	
func exit():
	wander_done = false

func _on_wander_timer_timeout():
	wander_done = true
