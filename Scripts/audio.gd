extends Control

@onready var music = $Music

func _ready() -> void:
	#music.play()
	pass
<<<<<<< Updated upstream

func switchtrack(track):
	$Music.stream = load(tracks[track])

func togglepausetrack(value: bool):
	$Music.stream_paused = value
