extends State

const item_scene = preload("res://scripts/item_drop/item_drop.tscn")
#const item_script = preload("res://scripts/item/item.gd")

func enter():
	super()
	

	
func drop_item():
	var item = ItemDrop.new_item(item(), character.global_position)
	#character.stage.get_node("Pickups").add_child(item)
	get_parent().get_parent().get_parent().get_node("Pickups").add_child(item)
	item.add_to_group("pickable")
	item.position = character.position

func _on_animation_animation_finished(anim_name):
	match anim_name:
		"dead":
			animation.play("kill")
			drop_item()
			drop_item()
		"kill":
			character.queue_free()

func item()-> String:
	var number = randf()
	#var number = randi_range(0,character.items_dropable.size()-1)
	if number > 0.2:
		return character.items_dropable[1]
	return character.items_dropable[0]
	#return character.items_dropable[number]
	
