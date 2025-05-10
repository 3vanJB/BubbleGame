class_name CharacterBase extends CharacterBody2D

@export_category("Starting Properties")
@export var movement_speed : float = 5
@export var max_hp : int = 100
@onready var hp : int = max_hp

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func teleport_to_location(destination: Vector2) -> void:
	global_position = destination
	
func move_right(move_direction : float) -> void:
	global_position.x += move_direction * movement_speed
	
func move_up(move_direction : float) -> void:
	global_position.y += move_direction * movement_speed


func takedamage(value):
	if hp - value < 0:
		hp = 0
	else:
		hp -= value

func heal(value):
	if hp + value > max_hp:
		hp = max_hp
	else:
		hp += value
