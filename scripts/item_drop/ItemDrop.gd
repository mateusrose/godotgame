extends RigidBody2D
class_name ItemDrop
@export var item_type : String
var can_pick_up = false

const item_scene = preload("res://scripts/item_drop/item_drop.tscn")
var experience_box = preload("res://assets/drops/experience.png")
var health_box = preload("res://assets/drops/heart.png")
var points = 10

var item_list = {"heart":health_box, "experience":experience_box}

func _process(delta):
	load_texture()

static func new_item(_item_type: String, pos: Vector2) -> ItemDrop:
	var new_item: ItemDrop = item_scene.instantiate()
	new_item.item_type = _item_type
	new_item.load_texture()
	var number = randi_range(0,1)
	if number == 0:
		new_item.linear_velocity.x = 10
	else:
		new_item.linear_velocity.x = -10
	new_item.global_position = pos
	return new_item

func load_texture():
	$Sprite.texture = item_list[item_type]


func _on_drop_timer_timeout():
	can_pick_up = true


func _on_area_2d_body_entered(body):
	if can_pick_up:
		match item_type:
			"heart":
				body.get_node("Health").change("increase", points)
				queue_free()
			"experience":
				body.get_node("Level").add_experience(points)
				queue_free()
