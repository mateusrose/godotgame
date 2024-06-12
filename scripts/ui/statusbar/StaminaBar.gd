extends TextureProgressBar
# Called when the node enters the scene tree for the first time.
func _ready():
	%Player.get_node("Stamina").stamina_changed.connect(update)
	update()

func update():
	value = %Player.get_node("Stamina").current_stamina * 100 / %Player.get_node("Stamina").max_stamina

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
