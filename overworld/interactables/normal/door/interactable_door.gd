class_name InteractableDoor extends InteractableObject

@export var bIsOpen : bool
@export var key_needed : String

func is_locked() -> bool:
	return !key_needed.is_empty()

func interact(character_consumed : PlayerCharacter) -> bool:
	if is_locked():
		if not unlock_door(character_consumed):
			return false
	bIsOpen = !bIsOpen
	# TODO: SFX
	return true

func unlock_door(character : PlayerCharacter) -> bool:
	if not character.keys_in_inventory.has(key_needed):
		return false
	character.keys_in_inventory.erase(key_needed)
	key_needed = ""
	# TODO: SFX Unlock
	return true
