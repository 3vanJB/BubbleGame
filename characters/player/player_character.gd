class_name PlayerCharacter extends CharacterBase

@export var interaction_radius : float = 50  # How far can the player interact with the object
var closest_interactable : InteractableObject = null

var keys_in_inventory : Array[String] = []

func add_key(key : String) -> void:
	if keys_in_inventory.has(key):
		return
	keys_in_inventory.append(key)

func can_interact_with_object(interactable : InteractableObject) -> bool:
	return global_position.distance_to(interactable.global_position) <= interaction_radius
	


func interact() -> void:
	if closest_interactable == null:
		return
	var bResult : bool = closest_interactable.interact(self)
	if bResult:
		# Interaction successful
		pass
	else:
		# Interaction failed
		pass
	
func _process(delta: float) -> void:
	update_closest_interactable()
	
	
func update_closest_interactable() -> void:
	pass
