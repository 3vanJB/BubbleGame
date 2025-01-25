extends Node2D
var m = preload("res://battle/battlemember.tscn")
@onready var playerparty = $playerparty
@onready var enemyparty = $enemyparty
@onready var UI = $UI
@export var echip : int = 0
@onready var buttonattack = $UI/HBoxContainer/buttonpanel/PanelContainer/attack
#checks to see if targeting enemy
var enemyfocused = false
var nextdamage

signal playeractionselected
var turns = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buttonattack.disabled = true
	var x = m.instantiate()
	x.ID = 0
	x.setup()
	turns.push_back(x)
	playerparty.members.push_back(x)
	playerparty.add_child(x)
	
	if MEMBERINFO.hasyoru == true:
		x = m.instantiate()
		x.ID = 1
		x.setup()
		turns.push_back(x)
		playerparty.members.push_back(x)
		playerparty.add_child(x)
		UI.sethplabel(1, playerparty.get_children()[1].curhp)
	
	UI.sethplabel(0, playerparty.get_children()[0].curhp)
	
	for i in len(MEMBERINFO.echips[echip]):
		x = m.instantiate()
		x.ID = MEMBERINFO.echips[echip][i]
		x.setup()
		turns.push_back(x)
		x.position = $enemyspawn.position
		x.position.x += (i * 300)
		enemyparty.members.push_back(x)
		enemyparty.add_child(x)
	nextturn()

func _process(delta: float) -> void:
	if enemyfocused == true:
		if Input.is_action_just_pressed("left"):
			enemyparty.scrolldown()
		if Input.is_action_just_pressed("right"):
			enemyparty.scrollup()
		if Input.is_action_just_pressed("ui_cancel"):
			enemyfocused = false
			buttonattack.grab_focus()
			buttonattack.disabled = false
			enemyparty.endfocus()

func nextturn():
	for i in len(turns):
		if turns[i].ally == false:
			print(turns[i].name + "'s turn")
		else:
			buttonattack.disabled = false
			buttonattack.grab_focus()
			await playeractionselected

func calculate(attacker, target):
	pass


func _on_attack_pressed() -> void:
	enemyfocused = true
	enemyparty.grabfocus(0)
	buttonattack.disabled = true
	buttonattack.release_focus()
