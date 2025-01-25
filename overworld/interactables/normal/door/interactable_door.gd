class_name InteractableDoor extends InteractableObject

@export var bIsOpen : bool
@export var opens_only_with_lever : bool = true
@export var key_needed : String
@export var open_texture : Texture2D
@export var close_texture : Texture2D
@export var new_level : String

func door_leads_to_new_scene() -> bool:
	return !new_level.is_empty() || !new_level.is_absolute_path()

func is_locked() -> bool:
	return !key_needed.is_empty()

func interact_door(character_consumed : PlayerCharacter) -> bool:
	if is_locked():
		if not unlock_door(character_consumed):
			return false
	bIsOpen = !bIsOpen
	return true
	# TODO: SFX

func interact(character_consumed : PlayerCharacter) -> bool:
	if bIsOpen and $Area2D.overlaps_body(character_consumed) and door_leads_to_new_scene():
		# TODO: transition to new level
		return true
	if opens_only_with_lever:
		return false
	interact_door(character_consumed)
	return true

func unlock_door(character : PlayerCharacter) -> bool:
	if not character.keys_in_inventory.has(key_needed):
		return false
	character.keys_in_inventory.erase(key_needed)
	key_needed = ""
	# TODO: SFX Unlock
	return true
