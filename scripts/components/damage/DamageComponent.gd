extends Node

@export var character: CharacterBody2D
@export var base_damage: int
@export var bonus_damage: int

func get_damage()->int:
	return bonus_damage + base_damage

	
func change(arg:String, value:int)->void:
	match arg:
		"increase_bonus":
			_increase_bonus_damage(value)
		"decrease_bonus":
			_decrease_bonus_damage(value)


func _increase_bonus_damage(value:int)->void:
	bonus_damage += value

func _decrease_bonus_damage(value:int)-> void:
	bonus_damage-=value
	
