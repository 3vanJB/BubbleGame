extends Node2D

var members = []
#Which enemy is selected
var cursor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func grabfocus(value):
	members[value].grabfocus()
	cursor = value

func scrollup():
	members[cursor].releasefocus()
	cursor += 1
	if cursor > len(members) - 1:
		cursor = 0
	members[cursor].grabfocus()

func scrolldown():
	members[cursor].releasefocus()
	cursor -= 1
	if cursor < 0:
		cursor = len(members) - 1
	members[cursor].grabfocus()

func endfocus():
	members[cursor].releasefocus()
	cursor = 0
