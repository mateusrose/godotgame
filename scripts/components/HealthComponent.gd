extends Node
class_name HealthComponent

@export var actor_path: NodePath
@onready var actor : CharacterBody2D = get_node(actor_path)
@export var base_health: int
@export var bonus_health: int
var can_take_damage = true
var current_health: int
var max_health: int
signal health_depleted
signal health_hit
signal health_increase
signal health_change

func _ready() -> void:
	current_health = base_health + bonus_health
	max_health = current_health
	
func change(arg:String, value:int)->void:
	match arg:
		"increase":
			_increase_health(value)
		"decrease":
			if can_take_damage:
				_decrease_health(value)
		"increase_bonus":
			_increase_bonus_health(value)
		"decrease_bonus":
			_decrease_bonus_health(value)
	health_change.emit()
	

func _increase_health(value:int)->void:
	current_health += value
	emit_signal("health_increase")
	if current_health > max_health:
		current_health = max_health

func _decrease_health(value:int)->void:
	current_health -= value
	emit_signal("health_hit")
	if current_health <= 0:
		current_health = 0
		
		emit_signal("health_depleted")
	
func _increase_bonus_health(value:int)->void:
	bonus_health += value
	max_health += value
	emit_signal("health_increase")
	if current_health > max_health:
		current_health = max_health

func _decrease_bonus_health(value:int)-> void:
	bonus_health-=value
	max_health-=value
	if current_health > max_health:
		current_health = max_health

func is_dead()->bool:
	if current_health <= 0:
		return true
	return false
