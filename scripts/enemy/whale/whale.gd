extends EnemyTemplate
class_name Whale



func _ready():
	randomize()
	drop_list = {
		"heal_potion":[
			"res://assets/item/consumable/health_potion.png",
			75,
			"Health"],
			"stamina_potion":[
			"res://assets/item/consumable/mana_potion.png",
			25,
			"Stamina"
		]
	}
