class_name BubbleTeleport extends Node2D

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
	

func get_new_direction() -> Vector2:
	return Vector2(randf(), randf()).normalized()

func _on_timer_timeout() -> void:
	movement_direction = get_new_direction()


func _on_bubble_pop_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	var character_collided : PlayerCharacter = body as PlayerCharacter
	if character_collided == null:
		print("aaaa")
		return
	character_collided.teleport_to_location(destination_location)
	queue_free()
