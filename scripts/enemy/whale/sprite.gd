extends EnemySprite
class_name WhaleSprite

var is_dead = false

func animate(velocity: Vector2) -> void:

	if enemy.can_hit or enemy.can_die or enemy.can_attack:
		action_behaviour()
	else:
		move_behaviour(velocity)
	
func move_behaviour(velocity:Vector2) -> void:
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")

func action_behaviour() -> void:
	if is_dead:
		animation.play("kill")
	elif enemy.is_waiting:
		return
	elif enemy.can_die and not is_dead:
		animation.play("dead")
		enemy.can_hit = false
		enemy.can_attack = false
	elif enemy.can_hit:
		animation.play("hit")
		enemy.can_attack = false
	elif enemy.can_attack:
		enemy.is_waiting = true
		animation.play("attack")

func _on_animation_finished(anim_name: String):
	match anim_name:
		"hit":
			enemy.can_hit = false
			##off on animation
			enemy.set_physics_process(true)
		"dead":
			is_dead = true
		"kill":
			enemy.queue_free()
		"attack":
			enemy.can_attack = false
			enemy.is_waiting = false
