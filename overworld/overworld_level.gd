extends Node2D


var current_character_controlled_index : int = 0
# var player_characters : Array[PlayerCharacter] = []

# Bubbles
@export_category("Bubbles")
@export var max_bubbles_in_level : int = 10
var teleport_bubbles_in_game : int

func spawn_new_bubble() -> void:
	var new_bubble : BubbleTeleport = load("res://misc/teleport bubble/bubble_teleport.tscn").instantiate() as BubbleTeleport
	if new_bubble == null:
		return
	teleport_bubbles_in_game += 1

func _on_bubble_spawn_timer_timeout() -> void:
	if teleport_bubbles_in_game >= max_bubbles_in_level:
		return
	spawn_new_bubble()
