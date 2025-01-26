extends Node2D

@onready var b = preload("res://battle/battle.tscn")
var current_character_controlled_index : int = 0
var player_characters : Array[PlayerCharacter] = []

# Bubbles
@export_category("Bubbles")
@export var max_bubbles_in_level : int = 10
var teleport_bubbles_in_game : int

func spawn_new_bubble() -> void:
	var new_bubble : BubbleTeleport = load("res://battle/teleport bubble/bubble_teleport.tscn").instantiate() as BubbleTeleport
	if new_bubble == null:
		return
	teleport_bubbles_in_game += 1

func _on_bubble_spawn_timer_timeout() -> void:
	if teleport_bubbles_in_game >= max_bubbles_in_level:
		return
	spawn_new_bubble()


#echip is short for encounter chip, it determines which enemies you encounter
func transition_to_battle(echip) -> void:
	$PlayerCharacter1.frozen = true
	var n = b.instantiate()
	n.echip = echip
	Changer.AnimPlayer.play("fadein")
	await Changer.AnimPlayer.animation_finished
	$TileMapLayer.hide()
	$PlayerCharacter1.hide()
	Audio.togglepausetrack(true)
	add_child(n)
	Changer.AnimPlayer.play("fadeout")

func transition_to_battle(battle_with_who : Array[EnemyCharacter]) -> void:
	# TODO: Transition to battle
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		$SceneChanger.start_transition("res://Options_UI.tscn")


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Battle Time")
	$SceneChanger.start_transition("res://battle/battle.gd")
func _on_area_2d_body_entered(body: Node2D) -> void:
	$Area2D.monitoring = false
	if body.is_in_group("overworldcontroller"):
		
		
		transition_to_battle(0)
func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Battle Time")
	$SceneChanger.start_transition("res://battle/battle.gd")
