extends Node2D


var current_character_controlled_index : int = 0
# var player_characters : Array[PlayerCharacter] = []

func spawn_new_bubble() -> void:

	# var new_bubble : BubbleTeleport = load("res://battle/teleport bubble/bubble_teleport.tscn").instantiate() as BubbleTeleport

	var new_bubble : BubbleTeleport = load("res://misc/teleport bubble/bubble_teleport.tscn").instantiate() as BubbleTeleport
	add_child(new_bubble)
	new_bubble.global_position = get_random_location_around_one_player()
	if new_bubble == null:
		return

func _on_bubble_spawn_timer_timeout() -> void:
	spawn_new_bubble()

func transition_to_battle(battle_with_who : Array[EnemyCharacter]) -> void:
	# TODO: Transition to battle
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		$SceneChanger.start_transition("res://Options_UI.tscn")

func get_random_location_around_one_player() -> Vector2:
	var character : PlayerCharacter = Auto.overworld_characters.pick_random()
	var x : float = randf_range(300, 400)
	var y : float = randf_range(100, 150)
	return Vector2(character.global_position.x + ((x * 1) if randi() % 2 == 0 else (x * -1)), character.global_position.y + ((x * 1) if randi() % 2 == 0 else (x * -1)))
