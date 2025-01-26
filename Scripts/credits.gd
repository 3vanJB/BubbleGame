extends Control
var hoversound = preload("res://SFX/Bubbles SFX Batch 1/UI/SFX_UI_Hover.wav")
var confirmsound = preload("res://SFX/Bubbles SFX Batch 1/UI/SFX_UI_Confirm.wav")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Audio.switchtotrack(0)
	Audio.set_pitch(0.7)
	
func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu.tscn")



func _on_exit_mouse_entered() -> void:
	Audio.playeffect(hoversound)
