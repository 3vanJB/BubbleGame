extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.switchtotrack(0)
	Audio.set_pitch(1)


func _on_play_pressed() -> void:
	# Should transition to level 1
	# $SceneChanger.start_transition("res://overworld/overworld_level.tscn") 
	Changer.start_transition("res://overworld/overworld_level.tscn") 
	$SFX_Click.play()

func _on_options_pressed() -> void:
	# Transition to Options scene
	Changer.start_transition("res://option_scene.tscn")
	$SFX_Click.play()

func _on_credits_pressed() -> void:
	Changer.start_transition("res://Credits.tscn")
	$SFX_Click.play()

func _on_quit_pressed() -> void:
	get_tree().quit()
	
