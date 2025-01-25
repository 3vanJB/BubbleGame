class_name BubbleTeleport extends RigidBody2D

# Nodes
@onready var sprite_node : Sprite2D = $sprite

# Teleport
@export var destination_location : Vector2

# Movement
var movement_direction : Vector2
@export var movement_speed : float


func _ready() -> void:
	movement_direction = get_new_direction()

func _physics_process(delta: float) -> void:
	global_position += movement_direction * movement_speed

func _on_body_entered(body: Node) -> void:
	if not body is CharacterBase:
		return
	var character_collided : CharacterBase = body as CharacterBase
	character_collided.teleport_to_location(destination_location)

func get_new_direction() -> Vector2:
	return Vector2(randf(), randf()).normalized()

func _on_timer_timeout() -> void:
	movement_direction = get_new_direction()


func _on_bubble_pop_timer_timeout() -> void:
	queue_free()
