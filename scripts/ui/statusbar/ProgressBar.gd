extends ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready():
	%Player.get_node("Health").health_change.connect(update)
	update()

func update():
	value = %Player.get_node("Health").current_health * 100 / %Player.get_node("Health").max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
