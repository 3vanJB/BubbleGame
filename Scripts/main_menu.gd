extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_play_pressed() -> void:
	# Should transition to level 1
	# $SceneChanger.start_transition("res://overworld/overworld_level.tscn") 
	Changer.start_transition("res://overworld/overworld_level.tscn") 

func _on_options_pressed() -> void:
	# Transition to Options scene
	Changer.start_transition("res://option_scene.tscn")

func _on_credits_pressed() -> void:
	Changer.start_transition("res://Credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
