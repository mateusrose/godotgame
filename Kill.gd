extends State

func enter():
	super()

func process_physics(delta: float) -> State:
	return null
	

func _on_animation_animation_finished(anim_name):
	match anim_name:
		"dead":
			animation.play("kill")
		"kill":
			character.queue_free()
