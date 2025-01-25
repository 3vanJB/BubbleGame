extends Node

var hasyoru = true


var members = {
	0:{
		"name":"Rose",
		"stats":{ "hp":10, "str":10, "def":3, "mgk":3, "mgkdef":3, "spd":3},
		"ally":true
	},
	1:{
		"name":"Yoru",
		"stats":{ "hp":10, "str":10, "def":3, "mgk":3, "mgkdef":3, "spd":3},
		"ally":true
	},
	2:{
		"name":"Adeline",
		"stats":{ "hp":10, "str":10, "def":3, "mgk":3, "mgkdef":3, "spd":3},
		"ally":true
	},
}

func getmemberstats(member):
	return members[member]["stats"]



var echips = {
	0:[2]
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
