extends EnemySprite
class_name WhaleSprite

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
	if enemy.can_die:
		animation.play("dead")
		enemy.can_hit = false
		enemy.can_attack = false
	elif enemy.can_hit:
		animation.play("hit")
		enemy.can_attack = false
	elif enemy.can_attack:
		animation.play("attack")

func _on_animation_finished(anim_name: String):
	match anim_name:
		"hit":
			enemy.can_hit = false
			##off on animation
			enemy.set_physics_process(true)
		"dead":
			enemy.kill_enemy()
		"kill":
			enemy.queue_free()
		"attack":
			enemy.can_attack = false
