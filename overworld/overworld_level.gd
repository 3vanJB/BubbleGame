extends Node2D

var b = preload("res://battle/battle.tscn")
var current_character_controlled_index : int = 0
# var player_characters : Array[PlayerCharacter] = []


func _ready() -> void:
	
	Audio.switchtotrack(1)

func spawn_new_bubble() -> void:

	# var new_bubble : BubbleTeleport = load("res://battle/teleport bubble/bubble_teleport.tscn").instantiate() as BubbleTeleport

	var new_bubble : BubbleTeleport = load("res://misc/teleport bubble/bubble_teleport.tscn").instantiate() as BubbleTeleport
	add_child(new_bubble)
	new_bubble.global_position = get_random_location_around_one_player()
	if new_bubble == null:
		return

func _on_bubble_spawn_timer_timeout() -> void:
	spawn_new_bubble()




func transition_to_battle(echip) -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	$PlayerCharacter1.frozen = true
	Dialogic.start("Pre Battle 1")	

func _on_timeline_ended() -> void:
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	var n = b.instantiate()
	n.echip = 0
	$PlayerCharacter1.frozen = true
	Changer.AnimPlayer.play("fadein")
	await Changer.AnimPlayer.animation_finished
	add_child(n)
	$TileMapLayer.hide()
	$TileMapLayer2.hide()
	$PlayerCharacter1.hide()
	Changer.AnimPlayer.play("fadeout")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Escape"):
		$SceneChanger.start_transition("res://Options_UI.tscn")

func get_random_location_around_one_player() -> Vector2:
	var character : PlayerCharacter = Auto.overworld_characters.pick_random()
	var x : float = randf_range(300, 400)
	var y : float = randf_range(100, 150)
	return Vector2(character.global_position.x + ((x * 1) if randi() % 2 == 0 else (x * -1)), character.global_position.y + ((x * 1) if randi() % 2 == 0 else (x * -1)))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("controller"):
		transition_to_battle(0)
