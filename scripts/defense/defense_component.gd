extends Node

class_name DefenseComponent

@export var base_defense: int = 1
@export var bonus_defense: int = 0
var current_defense: int
var is_blocking: bool = false

func _ready() -> void:
	current_defense = base_defense + bonus_defense
	
func verify_shield(damage: int) -> int:
	if is_blocking:
		return max(0, damage - current_defense)
	return damage
	
func increase_defense(value:int) -> void:
	bonus_defense += value
	current_defense += value

func decrease_defense(value:int) -> void:
	bonus_defense -= value
	current_defense -= value
