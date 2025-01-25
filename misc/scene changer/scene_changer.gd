class_name SceneChanger extends CanvasLayer

# @export var new_level_path : Resource   # THIS WILL BE PASSED FROM THE FUNCTION CALL
var new_level_path : String
var new_level : Node2D
@export var new_location : Vector2

enum E_change_scene_type {
	NEW_LEVEL,
	NEW_LOCATION
}
@export var change_scene_type : E_change_scene_type = E_change_scene_type.NEW_LEVEL


func change_scene_animation_event() -> void:
	match change_scene_type:
		E_change_scene_type.NEW_LEVEL:
			if new_level_path.is_empty() or not new_level_path.is_absolute_path():
				return
			get_tree().change_scene_to_file(new_level_path)
		E_change_scene_type.NEW_LOCATION:
			pass
		_:
			pass


func start_transition(in_new_level_path : String) -> void:
	new_level_path = in_new_level_path
	$AnimationPlayer.play("scene_change_animation")
