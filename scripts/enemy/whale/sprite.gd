extends EnemySprite
class_name WhaleSprite

func animate(velocity: Vector2) -> void:
	move_behaviour(velocity)
	
func move_behaviour(velocity:Vector2) -> void:
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")


