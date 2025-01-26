extends Control

var hoversound = preload("res://SFX/Bubbles SFX Batch 1/UI/SFX_UI_Hover.wav")
var confirmsound = preload("res://SFX/Bubbles SFX Batch 1/UI/SFX_UI_Confirm.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.switchtotrack(0)
	$Button_Container/Play.grab_focus()


func _on_play_pressed() -> void:
	# Should transition to level 1
	# $SceneChanger.start_transition("res://overworld/overworld_level.tscn") 
	Changer.start_transition("res://overworld/overworld_level.tscn") 
	Audio.playeffect(confirmsound)

func _on_options_pressed() -> void:
	# Transition to Options scene
	Changer.start_transition("res://option_scene.tscn")
	Audio.playeffect(confirmsound)

func _on_credits_pressed() -> void:
	Changer.start_transition("res://Credits.tscn")
	Audio.playeffect(confirmsound)

func _on_quit_pressed() -> void:
	get_tree().quit()
	


func _on_play_focus_entered() -> void:
	Audio.playeffect(hoversound)


func _on_play_mouse_entered() -> void:
	Audio.playeffect(hoversound)


func _on_options_focus_entered() -> void:
	Audio.playeffect(hoversound)


func _on_options_mouse_entered() -> void:
	Audio.playeffect(hoversound)


func _on_credits_focus_entered() -> void:
	Audio.playeffect(hoversound)


func _on_credits_mouse_entered() -> void:
	Audio.playeffect(hoversound)


func _on_quit_focus_entered() -> void:
	Audio.playeffect(hoversound)


func _on_quit_mouse_entered() -> void:
	Audio.playeffect(hoversound)
