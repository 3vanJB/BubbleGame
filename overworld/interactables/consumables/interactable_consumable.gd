class_name InteractableConsumable extends InteractableObject
@export var count : int = 1  # By default for non-stackable objects

func interact(character_consumed : PlayerCharacter) -> bool:
	super.interact(character_consumed)
	return true
