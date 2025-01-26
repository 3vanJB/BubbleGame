extends Control

@onready var music = $Music

var tracks = {
	0:"res://Audio/Title Theme.wav",
	1:"res://Audio/Dungeon Theme.mp3",
	2:"res://Audio/Battle Theme Fixed.mp3"
}


func _ready() -> void:
	pass

func switchtotrack(id):
	music.stream = load(tracks[id])

func togglestreampaused(value):
	music.stream_paused = value
