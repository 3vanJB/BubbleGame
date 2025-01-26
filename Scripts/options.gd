extends Control

var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("Effects")
var master = AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Slider Container/Master Slider".value = db_to_linear(AudioServer.get_bus_volume_db(master))
	$"Slider Container/Music Slider".value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	$"Slider Container/Sfx Slider".value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))


func _on_exit_pressed() -> void:
	if get_tree().current_scene.name == "option_scene":
		get_tree().change_scene_to_file("res://Main Menu.tscn")
		$SFX_Click.play()
		#print(get_tree().current_scene.name)
	else:
		$SFX_Click.play()
		visible = false
		#print(get_tree().current_scene.name)

func _on_music_slider_value_changed(value: float) -> void:
	$SFX_Hover.play()
	AudioServer.set_bus_volume_db(music_bus,linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	$SFX_Hover.play()
	AudioServer.set_bus_volume_db(sfx_bus,linear_to_db(value))

func _on_master_slider_value_changed(value: float) -> void:
	$SFX_Hover.play()
	AudioServer.set_bus_volume_db(master,value)

func _on_quit_pressed() -> void:
	$SFX_Click.play()
	get_tree().quit()
