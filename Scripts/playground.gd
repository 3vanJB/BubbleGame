extends Node2D

@onready var option = $Control/Player/Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	Auto.goto_scene("res://Main Menu.tscn")

func _input(event) -> void:
	if event.is_action_pressed("Escape"):
		option.visible = true
	
