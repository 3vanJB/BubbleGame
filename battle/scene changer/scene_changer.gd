class_name SceneChanger extends CanvasLayer

@export var new_level_path : Resource
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
			get_tree().change_scene_to_file(new_level_path.resource_path)
		E_change_scene_type.NEW_LOCATION:
			pass
		_:
			pass
