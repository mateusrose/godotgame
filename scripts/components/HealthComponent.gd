extends Node
class_name HealthComponent

@export var base_health: int
@export var bonus_health: int
var current_health: int
var max_health: int
signal health_depleted
signal health_hit
signal health_increase

func _ready() -> void:
	current_health = base_health + bonus_health
	max_health = current_health
	
func increase_health(value:int)->void:
	current_health += value
	emit_signal("health_increase")
	if current_health > max_health:
		current_health = max_health

func decrease_health(value:int)->void:
	current_health -= value
	emit_signal("health_hit")
	if current_health <= 0:
		current_health = 0
		emit_signal("health_depleted")
	
func increase_bonus_health(value:int)->void:
	bonus_health += value
	max_health += value
	emit_signal("health_increase")
	if current_health > max_health:
		current_health = max_health

func decrease_bonus_health(value:int)-> void:
	bonus_health-=value
	max_health-=value
	if current_health > max_health:
		current_health = max_health
