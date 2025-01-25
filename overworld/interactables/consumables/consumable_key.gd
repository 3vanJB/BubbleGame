class_name ConsumableKey extends InteractableConsumable

@export var key_name : String

func interact(character_consumed : PlayerCharacter) -> bool:
	character_consumed.add_key(key_name)
	super.interact(character_consumed)
	return true


func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if not body is PlayerCharacter:
		return
	interact(body as PlayerCharacter)
