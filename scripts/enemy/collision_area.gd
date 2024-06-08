extends Area2D
class_name CollisionArea

@onready var timer: Timer = $Timer
@export var health : int
@export var invulnerability_time : int
@export var enemy_path:NodePath 
@onready var enemy: CharacterBody2D = get_node(enemy_path)


func _on_collision_area_entered(area):
	if area.is_in_group("player_attack"):
			var player_stats: Node = area.get_parent().get_node("Stats")
			var player_attack: int = player_stats.base_attack + player_stats.bonus_attack
			update_health(player_attack)
		
		
func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		enemy.can_die = true
		return
	enemy.can_hit = true
	

