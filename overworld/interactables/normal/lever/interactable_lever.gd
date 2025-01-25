class_name InteractableLever extends InteractableObject

@export var bIsOn : bool
@export var open_texture : Texture2D
@export var close_texture : Texture2D
@export var door_linked : InteractableDoor

func interact(character_consumed : PlayerCharacter) -> bool:
	if door_linked.is_locked():
		return false
	bIsOn = !bIsOn
	$Sprite2D.texture = open_texture if bIsOn else close_texture
	door_linked.interact(character_consumed)
	# TODO: Play Lever SFX
	return true
