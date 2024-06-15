extends Node

class_name ExperienceComponent

@export var level_dict: Dictionary = {
	"1": 25,
	"2": 33,
	"3": 49,
	"4": 66,
	"5": 93,
	"6": 135,
	"7": 186,
	"8": 251,
	"9": 356
}

var current_exp: int = 0
var level: int = 1

signal level_up

func add_experience(value: int) -> void:
	current_exp += value
	if level < 9 and current_exp >= level_dict[str(level)]:
		var leftover: int = current_exp - level_dict[str(level)]
		current_exp = leftover
		level += 1
		print("level up, currently on level ", level)
		emit_signal("level_up")
	elif level == 9:
		current_exp = level_dict[str(level)]
	print(current_exp, " gained exp")


func _on_level_up():
	match level:
		2:
			print("You can now press shift to dash, try doing it against a short wall")
		4: 
			print("You can now press G to activate demon mode while still, slowing time down for preciser movement")
