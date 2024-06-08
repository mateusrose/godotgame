extends Node
class_name StaminaComponent

@export var actor_path: NodePath
@onready var actor : CharacterBody2D = get_node(actor_path)
@export var base_stamina: int
@export var bonus_stamina: int
var current_stamina: int
var previous_stamina: int
var max_stamina: int
var increase_rate_stamina: int
signal stamina_depleted
@onready var stamina_recover_timer: Timer = get_node_or_null("StaminaRecover")

func _ready() -> void:
	current_stamina = base_stamina + bonus_stamina
	max_stamina = current_stamina
	increase_rate_stamina = max_stamina/2
	
	if stamina_recover_timer == null:
		stamina_recover_timer = Timer.new()
		stamina_recover_timer.name = "StaminaRecover"
		stamina_recover_timer.wait_time = 0.5  
		stamina_recover_timer.one_shot = false
		stamina_recover_timer.connect("timeout",_on_stamina_recover_timeout)
		add_child(stamina_recover_timer)
	stamina_recover_timer.stop()  # Ensure the timer is stopped initially
	stamina_recover_timer.start()

func change(arg:String, value:int)->void:
	match arg:
		"increase":
			increase_stamina(value)
		"decrease":
			decrease_stamina(value)
		"increase_bonus":
			increase_bonus_stamina(value)
		"decrease_bonus":
			decrease_bonus_stamina(value)

func increase_stamina(value:int)->void:
	current_stamina += value
	if current_stamina > max_stamina:
		current_stamina = max_stamina

func decrease_stamina(value:int)->void:
	current_stamina -= value
	if current_stamina <= 0:
		current_stamina = 0
		emit_signal("stamina_depleted")
	previous_stamina = current_stamina
	
func increase_bonus_stamina(value:int)->void:
	bonus_stamina += value
	max_stamina = base_stamina + bonus_stamina 
	if current_stamina > max_stamina:
		current_stamina = max_stamina

func decrease_bonus_stamina(value:int)-> void:
	bonus_stamina -= value
	max_stamina = base_stamina + bonus_stamina 
	if current_stamina > max_stamina:
		current_stamina = max_stamina

func _on_stamina_recover_timeout():
	if previous_stamina <= current_stamina and current_stamina != max_stamina:
		increase_stamina(increase_rate_stamina)
