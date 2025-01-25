extends Node

var hasyoru = true

var partyhp = {
	0:10,
	1:10
}


var members = {
	0:{
		"name":"Rose",
		"stats":{ "hp":50, "str":15, "def":10, "mgk":7, "mgkdef":8, "spd":3},
		"ally":true
	},
	1:{
		"name":"Yoru",
		"stats":{ "hp":30, "str":8, "def":8, "mgk":15, "mgkdef":10, "spd":3},
		"ally":true
	},
	2:{
		"name":"Adeline",
		"stats":{ "hp":100, "str":10, "def":3, "mgk":3, "mgkdef":3, "spd":3},
		"ally":false
	},
}

func getmemberstats(ID):
	return members[ID]["stats"]
func getmember(ID):
	return members[ID]


var echips = {
	0:[2]
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
