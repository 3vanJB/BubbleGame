extends Node2D
var m = preload("res://battle/battlemember.tscn")
@onready var playerparty = $playerparty
@onready var enemyparty = $enemyparty
@export var echip : int = 0
var turns = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x = m.instantiate()
	x.ID = 0
	x.setup()
	turns.push_back(x)
	playerparty.add_child(x)
	
	if MEMBERINFO.hasyoru == true:
		x = m.instantiate()
		x.ID = 1
		x.setup()
		turns.push_back(x)
		playerparty.add_child(x)
	
	for i in MEMBERINFO.echips[echip]:
		x = m.instantiate()
		x.ID = i
		x.setup()
		turns.push_back(x)
		x.position = $enemyspawn.position
		enemyparty.add_child(x)
	print(turns)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
