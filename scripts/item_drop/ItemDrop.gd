extends RigidBody2D
class_name ItemDrop
@export var item_type : String
var can_pick_up = false
var character = null

const item_scene = preload("res://scripts/item_drop/item_drop.tscn")
var experience_box = preload("res://assets/drops/experience.png")
var health_box = preload("res://assets/drops/heart.png")
var points = 10

var item_list = {"heart":health_box, "experience":experience_box}

func _physics_process(_delta):
	load_texture()
	if can_pick_up and character != null:
		pick_up()
		
static func new_item(_item_type: String, pos: Vector2) -> ItemDrop:
	var new_item_drop: ItemDrop = item_scene.instantiate()
	new_item_drop.item_type = _item_type
	new_item_drop.load_texture()
	var number = randi_range(0,1)
	if number == 0:
		pass
		#new_item.linear_velocity.x = randi_range(1,100)
	else:
		pass
		#new_item.linear_velocity.x = randi_range(-1,-100)
	new_item_drop.global_position = pos
	return new_item_drop

func load_texture():
	$Sprite.texture = item_list[item_type]


func _on_drop_timer_timeout():
	can_pick_up = true

func _on_area_2d_body_entered(body:Player_Character):
	character = body
	
func _on_area_2d_body_exited(body:Player_Character):
	character = null
	
func pick_up():
	match item_type:
			"heart":
				character.get_node("Health").change("increase", points)
				queue_free()
			"experience":
				character.get_node("Level").add_experience(points)
				queue_free()

