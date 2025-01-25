extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var _anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:

	# Handles Y coordinate movement.
	var directionY := Input.get_axis("ui_up","ui_down")
	if directionY:
		velocity.y = directionY * SPEED
		_anim.play("vertical")
		_anim.flip_v = false
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		_anim.play("vertical")
		_anim.flip_v = true
	#---------------------------------------------------------------
	#---------------------------------------------------------------
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		_anim.play("horizontal")
		_anim.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#_anim.play("horizontal")
		_anim.flip_h = true

	move_and_slide()


func _on_exit_pressed() -> void:
	Auto.goto_scene("res://Main Menu.tscn")
