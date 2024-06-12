extends PointLight2D


func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_parent().stage != null:
		if !get_parent().stage.is_day:
			energy = 1
		else:
			energy = 0.3
		
