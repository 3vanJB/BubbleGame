extends Node
# Audio variable
var sound = 1
var effect = 1
# Scene Variable
var current_scene = null
var bIsInOverworld : bool = true
var overworld_characters : Array[PlayerCharacter] = []  # gets initialized by playercharacter

func init_characters() -> void:
	overworld_characters[0].bIsBeingControlled = true
	overworld_characters[0].bIsBeingControlled = false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func goto_scene(path):
		# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	_deferred_goto_scene.call_deferred(path)

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()
	# Load new scene
	var s = ResourceLoader.load(path)
	# Instantiate new scene
	current_scene = s.instantiate()
	#Add it to the active scene as child of root
	get_tree().root.add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	


func transition_to_battle(battle_with_who : Array[EnemyCharacter], triggered_by : EnemyCharacter) -> void:
	if not bIsInOverworld:
		return
	# TODO: show the dialogue box
	# TODO: go from overworld to battle scene
	bIsInOverworld = false
	
func transition_to_overworld(bCharacter1Dead : bool, bCharacter2Dead : bool) -> void:
	if bIsInOverworld:
		return
	if bCharacter1Dead:
		overworld_characters.remove_at(0)
	if bCharacter2Dead:
		overworld_characters.remove_at(1)
	if overworld_characters.size() == 0:
		lose_game()
		return
	# TODO: Transition from battle to overworld
	get_tree().change_scene_to_file("res://overworld/overworld_level.tscn")
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)
	# print(current_scene.name)
	for character in overworld_characters:
		current_scene.add_child(character)
	bIsInOverworld = true

func lose_game() -> void:
	pass
