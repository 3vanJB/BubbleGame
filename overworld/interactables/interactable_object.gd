class_name InteractableObject extends Node2D

@export_category("Properties")
@export var object_name : String

func interact(character_consumed : PlayerCharacter) -> bool:
	# TODO: Ena, make the interaction dialog and etc in the SUBCLASSES of this class in the method interact()
	# TODO: Make sounds here for interaction sounds
	queue_free()
	return true  # by default. Will override in subclasses (aka other interactables)
