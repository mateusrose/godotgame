extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	for child in get_children():
		if get_parent().is_day:
			child.enabled = false
		else:
			child.enabled = true
