extends Node2D

func _ready() -> void:
	Audio.switchtotrack(0)
	Audio.set_pitch(1.5)
	$AnimationPlayer.play("Credits")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Changer.start_transition("res://Main Menu.tscn")
