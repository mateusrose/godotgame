extends Node
class_name State

@export var character : CharacterBody2D
@export var animation : AnimationPlayer
@export var animation_name : String
@export var sprite : Sprite2D

func enter():
	animation.play(animation_name)
func exit():
	return null
	
func process_input(event:InputEvent) -> State:
	return null
	
func process_frame(delta:float) -> State:
	return null
	
func process_physics(delta:float)->State:
	return null
