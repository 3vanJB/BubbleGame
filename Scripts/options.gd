extends Control

var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("Effects")
var master = AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var value = db_to_linear(master)
	value_changed =


func _on_exit_pressed() -> void:
	if get_tree().current_scene.name == "option_scene":
		Auto.goto_scene("res://Main Menu.tscn")
		#print(get_tree().current_scene.name)
	else:
		visible = false
		#print(get_tree().current_scene.name)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus,linear_to_db(value))
	if value == -20:
		AudioServer.set_bus_mute(music_bus,true)
	else:
		AudioServer.set_bus_mute(music_bus,false)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus,linear_to_db(value))


func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master,value)
	if value == -20:
		AudioServer.set_bus_mute(master,true)
	else:
		AudioServer.set_bus_mute(master,false)
