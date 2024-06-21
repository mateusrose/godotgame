extends Label
@export var player : Player_Character	
var level_message:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Timer").start()
	level_message = player.get_node("Level").level_up.connect(_on_level_up_message)
	pass # Replace with function body.


func _on_level_up_message():
	level_message = player.get_node("Level").level
	match level_message:
		2:
			_show_message(2)
		3:
			_show_message(0)
		4:
			_show_message(4)
		5:
			_show_message(0)

func _show_message(value:int):
	match value:
		0:
			visible = true
			text = "Level " + str(level_message)
			get_node("Timer").start()
		1:
			visible = true
			get_node("Timer").start()
		2:
			visible = true
			text = "Level 2 \n Press Right-Click \n or Shift \n or Alt \n to dash \n Do it on a wall"
			get_node("Timer").start()
		4:
			visible = true
			text = "Level 4 \n Press G \n to slow time"
			get_node("Timer").start()

func _on_timer_timeout():
	visible = false
