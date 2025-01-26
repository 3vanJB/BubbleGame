extends Control

@onready var music = $Music
@onready var sfx = $Effects
var tracks = {
	0:"res://Audio/Title Theme.wav",
	1:"res://Audio/Dungeon Theme.mp3",
	2:"res://Audio/Battle Theme Fixed.mp3"
}


func _ready() -> void:
	pass

func switchtotrack(id):
	music.stream = load(tracks[id])
	music.play()

func togglestreampaused(value):
	music.stream_paused = value
<<<<<<< HEAD
	
func set_pitch(value):
	music.set_pitch_scale(value)
=======

func playeffect(eff):
	if eff != null:
		sfx.stream = eff
		sfx.play()
		print("sfx play")
>>>>>>> fac520d3f78485d4d1ed5a4ec2711ee60ce2e8f6
