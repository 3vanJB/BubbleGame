extends Node2D

var members = []
var cursor = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@onready var UI = $"../UI"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func grabfocus(value):
	UI.grabmemberfocus(cursor)
	cursor = value

func scrollup():
	UI.releasememberfocus(cursor)
	cursor += 1
	if cursor > len(members) - 1:
		cursor = 0
	UI.grabmemberfocus(cursor)

func scrolldown():
	UI.releasememberfocus(cursor)
	cursor -= 1
	if cursor < 0:
		cursor = len(members) - 1
	UI.grabmemberfocus(cursor)

func endfocus():
	UI.releasememberfocus(cursor)
	cursor = 0
