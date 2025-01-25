extends Node2D



var current_character_controlled_index : int = 0
var player_characters : Array[PlayerCharacter] = []

# Bubbles
@export_category("Bubbles")
@export var max_bubbles_in_level : int = 10
@export var WALL_TILE_ID : int = 0
var playable_cells = []

func _ready() -> void:
	setup_playable_areas()

func get_random_location_playable_area() -> Vector2:
	if playable_cells.size() > 0:
		var random_index = randi() % playable_cells.size()
		var spawn_position = playable_cells[random_index]

		# Convert the cell position to world coordinates
		return $Ground.map_to_local(spawn_position).to_global()
	return Vector2(50, 50)
		

	
func get_random_location_from_point(OriginLocation : Vector2, random_radius : float) -> Vector2:
	return Vector2(OriginLocation.x + randf_range(-random_radius, random_radius), OriginLocation.y + randf_range(-random_radius, random_radius))

func setup_playable_areas() -> void:
	# Get the used rectangle in the TileMap
	var used_rect = $Ground.get_used_rect()

	# Iterate through the used rectangle to find non-wall tiles
	for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
		for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
			var cell_position = Vector2(x, y)
			var tile_id = $Ground.get_cellv(cell_position)
			
			# Add to playable cells if it's not a wall
			if tile_id != WALL_TILE_ID:  # Replace WALL_TILE_ID with your wall tile ID
				playable_cells.append(cell_position)


func spawn_new_bubble() -> void:
	

	# Instance the scene and add it to the game
	var new_bubble : BubbleTeleport = load("res://battle/teleport bubble/bubble_teleport.tscn").instance() as BubbleTeleport
	if new_bubble == null:
		return
	new_bubble.global_position = get_random_location_playable_area()  # Set the world position
	add_child(new_bubble)
	
	
	
	# new_bubble.set_global_position(get_random_location_playable_area())
	

func _on_bubble_spawn_timer_timeout() -> void:
	spawn_new_bubble()


func transition_to_battle(battle_with_who : Array[EnemyCharacter]) -> void:
	# TODO: Transition to battle
	pass
