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
	lastpresseddirection = velocity
	var vertical := Input.get_axis("ui_up","ui_down")
	if frozen == false:
		if vertical:
			if bIsBeingControlled:
				velocity.y = vertical * SPEED
			$AnimationPlayer.play("walk front" if velocity.y > 0 else "walk back")
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
				$AnimationPlayer.play("walk left" if velocity.x < 0 else "walk right")
		
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if not velocity:
			if lastpresseddirection.x != 0:
				$AnimationPlayer.play("idle left" if lastpresseddirection.x < 0 else "idle right")
			if lastpresseddirection.y != 0:
				$AnimationPlayer.play("idle back" if lastpresseddirection.y < 0 else "idle front")
		#print("idle" + $AnimationPlayer.current_animation.split("idle")[1])
		if $Sprite2D2.global_position.distance_to($point.global_position) > 3:
			$Sprite2D2.global_position += $Sprite2D2.global_position.direction_to($point.global_position) * 3
			$Sprite2D2/AnimationPlayer.play("walk " + $AnimationPlayer.current_animation.split(" ")[1])
		elif velocity:
			$Sprite2D2/AnimationPlayer.play("walk " + $AnimationPlayer.current_animation.split(" ")[1])
		elif $Sprite2D2.global_position.distance_to($point.global_position) < 5 and not velocity:
			$Sprite2D2/AnimationPlayer.play("idle " + $AnimationPlayer.current_animation.split(" ")[1])
			
		#$Sprite2D2.position.y = move_toward($Sprite2D.position.y, $point.position.y, 50)
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
