class_name InteractableLever extends InteractableObject

@export var bIsOn : bool
@export var open_texture : Texture2D
@export var close_texture : Texture2D
@export var door_linked : InteractableDoor

func interact(character_consumed : PlayerCharacter) -> bool:
	if door_linked != null:
		if door_linked.is_locked():
			return false
		bIsOn = !bIsOn
		#$Sprite2D.texture = open_texture if bIsOn else close_texture
		$Sprite2D.flip_h = true if bIsOn else false
		door_linked.interact_door(character_consumed)
		# TODO: Play Lever SFX
		return true
	return false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("controller"):
		interact(body)
