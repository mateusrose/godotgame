extends Node
class_name PlayerStats

@export var player_path: NodePath
@onready var player : CharacterBody2D = get_node(player_path)
@onready var collision_area : Area2D = player.get_node("CollisionArea")
@onready var inv_timer : Timer = $InvencibilityTimer

var blocking: bool = false
var base_health: int = 15
var base_mana: int = 10
var base_attack: int = 1
var base_magic_attack: int = 3
var base_defense: int  = 1

var bonus_health: int = 0
var bonus_mana: int = 0
var bonus_attack: int = 0
var bonus_magic_attack: int = 0
var bonus_defense: int  = 0

var current_health: int
var current_mana : int

var max_mana: int
var max_health: int

var current_exp: int = 0

var level: int = 1
var level_dict : Dictionary = {
	"1" : 25,
	"2" : 33,
	"3" : 49,
	"4" : 66,
	"5" : 93,
	"6" : 135,
	"7" : 186,
	"8" : 251,
	"9" : 356
}

func _ready() -> void:
	current_mana = base_mana + bonus_mana
	max_mana = current_mana
	collision_area.area_entered.connect(_on_collision_area_entered)
	inv_timer.timeout.connect(_on_invicibility_timer_timeout)
	current_health = base_health + bonus_health
	max_health = current_health
	
func update_exp(value: int) -> void:
	current_exp += value
	if current_exp >= level_dict[str(level)] and level < 9:
		var leftover: int = current_exp - level_dict[str(level)]
		current_exp = leftover
		on_level_up()
		level += 1
	elif current_exp >= level_dict[str(level)] and level == 9:
		current_exp = level_dict[str(level)]

func on_level_up() -> void:
	current_mana = base_mana + bonus_mana
	current_health = base_health + bonus_health


func update_health(type: String, value:int) -> void:
	match type:
		"Increase":
			current_health += value
			if current_health >= max_health:
				current_health = max_health
		"Decrease":
			verify_shield(value)
			if current_health <= 0:
				player.dead = true
			else:
				player.on_hit = true
				player.is_attacking = false
			
func verify_shield(value: int) -> void:
	#refactor to oop after
	if blocking:
		if (base_defense + bonus_defense) > value:
			return
		var damage: int = abs((base_defense + bonus_defense) - value)
		current_health -= damage
	else:
		current_health -= value
		
func update_mana(type:String, value:int) -> void :
	match type:
		"Increase":
			current_mana += value
			if current_mana >= max_mana:
				current_mana = max_mana
		"Decrease":
			current_mana -= value
			
#func _process(_delta) -> void:
	#if Input.is_action_just_pressed("ui_select"):
		#update_health("Decrease", 5)
		
func _on_collision_area_entered(area):
	if area.name == "EnemyAttackArea":
		update_health("Decrease", area.damage)
		collision_area.set_deferred("monitoring", false)
		inv_timer.start(area.inv_timer)
		
func _on_invicibility_timer_timeout()-> void:
	collision_area.set_deferred("monitoring",true)
