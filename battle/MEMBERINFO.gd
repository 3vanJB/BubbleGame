extends Node

var hasyoru = true

var partyhp = {
	0:50,
	1:30
}


var members = {
	0:{
		"name":"Rose",
		"stats":{ "hp":80, "str":15, "def":5, "mgk":7, "mgkdef":8, "spd":3},
		"ally":true
	},
	1:{
		"name":"Yoru",
		"stats":{ "hp":50, "str":8, "def":5, "mgk":15, "mgkdef":10, "spd":3},
		"ally":true
	},
	2:{
		"name":"Adeline",
		"stats":{ "hp":100, "str":10, "def":3, "mgk":3, "mgkdef":3, "spd":3},
		"ally":false,
		"sprite":"res://battle/enemyanimations/jubjub.tscn"
	},
	3:{
		#orang bubble
		"name":"Furious Jubjub",
		"stats":{ "hp":30, "str":10, "def":5, "mgk":6, "mgkdef":3, "spd":3},
		"ally":false,
		"skills":[7, 8],
		"sprite":"res://battle/enemyanimations/jubjub.tscn"
	},
	4:{
		#purp bubble
		"name":"Jittering Eye Man",
		"stats":{ "hp":20, "str":8, "def":10, "mgk":8, "mgkdef":8, "spd":3},
		"ally":false,
		"sprite":"res://battle/enemyanimations/eyeman.tscn"},
	5:{
		#cyan
		"name":"Divine Eunice",
		"stats":{ "hp":25, "str":10, "def":8, "mgk":20, "mgkdef":15, "spd":3},
		"ally":false,
		"sprite":"res://battle/enemyanimations/eunice.tscn"}
}

func getmemberstats(ID):
	return members[ID]["stats"]
func getmember(ID):
	return members[ID]


var echips = {
	0:[4, 3]
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
