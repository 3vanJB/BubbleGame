extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Audio.switchtotrack(0)
	Audio.set_pitch(0.7)
	
func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu.tscn")
