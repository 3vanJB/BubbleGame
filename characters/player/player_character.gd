class_name PlayerCharacter extends CharacterBase

@export var interaction_radius : float = 50  # How far can the player interact with the object
var closest_interactable : InteractableObject = null

var keys_in_inventory : Array[String] = []
var lastpresseddirection

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var bIsBeingControlled : bool = false  # one has to set to true on init game
var frozen = false

func _ready() -> void:
	Auto.overworld_characters.append(self)
	$SpriteAnim.play()

func _physics_process(delta: float) -> void:
	# Handle jump.
	var vertical := Input.get_axis("ui_up","ui_down")
	if vertical:
		if bIsBeingControlled:
			velocity.y = vertical * SPEED
		$AnimationPlayer.play("idlefront" if velocity.y > 0 else "idleback")
		#$SpriteAnim.set_animation()
		#$SpriteAnim
	else:	
		velocity.y = move_toward(velocity.y, 0, SPEED)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal := Input.get_axis("ui_left", "ui_right")
	if horizontal:
		if bIsBeingControlled:
			velocity.x = horizontal * SPEED
		if velocity.x != 0:
			#$SpriteAnim.set_animation("idle_left" if velocity.x < 0 else "idle_right")
			#$SpriteAnim.play()
			$AnimationPlayer.play("idleleft" if velocity.x < 0 else "idleright")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if frozen == false:
		move_and_slide()




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
