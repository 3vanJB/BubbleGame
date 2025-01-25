extends Node2D
var m = preload("res://battle/battlemember.tscn")
@onready var playerparty = $playerparty
var enemyparty
@export var echip : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x = m.instantiate()
	x.ID = 0
	x.setup()
	playerparty.add_child(x)
	if MEMBERINFO.hasyoru == true:
		pass
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
