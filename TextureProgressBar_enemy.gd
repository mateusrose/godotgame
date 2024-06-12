extends TextureProgressBar
var old_health : int
# Called when the node enters the scene tree for the first time.
func _ready():
	%Health.health_change.connect(update)
	update()

func update():
	value = %Health.current_health * 100 / %Health.max_health
	old_health = value
	%HealthWhiteTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	%HealthProgressWhite.value = old_health
