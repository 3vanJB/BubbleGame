class_name ConsumableHealth extends InteractableConsumable

func interact(character_consumed : PlayerCharacter) -> bool:
	character_consumed.heal(count)
	super.interact(character_consumed)
	return true


func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if not body is PlayerCharacter:
		return
	interact(body as PlayerCharacter)
