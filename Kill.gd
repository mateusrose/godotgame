extends State

const item_scene := preload("res://scripts/item/item_template.tscn")

func enter():
	super()
	drop_item()

func process_physics(delta: float) -> State:
	return null
	
func drop_item():
	var item = ItemTemplate.new_item(item(), character.global_position)
	character.stage.call_deferred("add_child", item)
	item.add_to_group("pickable")
	item.position = character.position

func _on_animation_animation_finished(anim_name):
	match anim_name:
		"dead":
			animation.play("kill")
		"kill":
			character.queue_free()

func item()-> String:
	var number = randi_range(0,character.items_dropable.size()-1)
	return character.items_dropable[number]
	
