extends Control



func _on_play_pressed():
	var demo_level = load("res://scenes/env/demo_level.tscn")
	get_tree().change_scene_to_file("res://scenes/env/demo_level.tscn")


func _on_options_pressed():
	$MarginContainer/Main.visible = false
	$MarginContainer/Options.visible = true


func _on_quit_pressed():
	get_tree().quit();


func _on_back_pressed():
	$MarginContainer/Options.visible = false
	$MarginContainer/Main.visible = true


func _on_controls_pressed():
	$MarginContainer/Options.visible = false
	$Controls.visible = true
	$MarginContainer/Controls.visible = true


func _on_controls_back_pressed():
	$Controls.visible = false
	$MarginContainer/Controls.visible = false
	$MarginContainer/Options.visible = true
	
