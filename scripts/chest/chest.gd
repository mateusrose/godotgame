extends Area2D
class_name Chest
@export var items_dropable: Array[String]
const item_scene = preload("res://scripts/item_drop/item_drop.tscn")
var is_open = false

func _on_body_entered(body: Player_Character):
	if body:
		if is_open:
			return
		$Animation.play("opening")
		$DropTimer.start()
		is_open = true
	
func _on_drop_timer_timeout():
	drop_item()
	drop_item()
	drop_item()
	
func drop_item():
	var item = ItemDrop.new_item(item_type(), global_position)
	#character.stage.get_node("Pickups").add_child(item)
	get_parent().get_node("Pickups").add_child(item)
	item.add_to_group("pickable")
	item.position = position
	
func item_type()-> String:
	var number = randf()
	if number > 0.1:
		return items_dropable[1]
	return items_dropable[0]
