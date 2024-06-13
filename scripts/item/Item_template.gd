extends RigidBody2D
class_name ItemTemplate
var item_type : String
var can_pick_up = false

const item_scene := preload("res://scripts/item/item_template.tscn")
var experience_box = preload("res://assets/drops/experience.png")
var health_box = preload("res://assets/drops/heart.png")
var points = 10

var item_list = {"heart":health_box, "experience":experience_box}
	
static func new_item(_item_type: String, pos: Vector2) -> ItemTemplate:
	var new_item: ItemTemplate = item_scene.instantiate()
	new_item.item_type = _item_type
	new_item.load()
	new_item.global_position = pos
	return new_item

func load():
	$Sprite.texture = item_list[item_type]

func _on_pickable_body_entered(body:Player_Character):
	print("you can pick up:", can_pick_up)
	if can_pick_up:
		match item_type:
			"heart":
				body.get_node("Health").change("increase", points)
				queue_free()
			"experience":
				body.get_node("Level").add_experience(points)
				queue_free()


func _on_drop_time_timeout():
	print("ola")
	can_pick_up = true
	print(can_pick_up)
