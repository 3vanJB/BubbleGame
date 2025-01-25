extends Node2D
#
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
var current

# Bubbles
@export_category("Bubbles")
@export var max_bubbles_in_level : int = 10
var teleport_bubbles_in_game : int




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
		if Input.is_action_just_pressed("ui_accept"):
			enemyfocused = false
			print(current.membername)
			calculate(current, enemyparty.members[enemyparty.cursor])
			enemyparty.endfocus()
			emit_signal("playeractionselected")
			

func nextturn():
	for i in len(turns):
		current = turns[i]
		if turns[i].ally == false:
			#print(turns[i].membername + "'s turn")
			turns[i].action = load(ACTIONS.actions[0])
		else:
			buttonattack.disabled = false
			#print(turns[i].membername + "'s turn")
			buttonattack.grab_focus()
			await playeractionselected
	nextturn()

func calculate(attacker, target):
	if attacker.action.isattack == true:
		var damage = (4 * attacker.stats["str"] - 3 * target.stats["def"]) * attacker.action.power
		nextdamage = damage
		target.takedamage(damage)


func _on_attack_pressed() -> void:
	buttonattack.disabled = true
	enemyfocused = true
	enemyparty.grabfocus(0)
	current.action = load(ACTIONS.actions[0])
	buttonattack.release_focus()


func spawn_new_bubble() -> void:
	var new_bubble : BubbleTeleport = load("res://battle/teleport bubble/bubble_teleport.tscn").instance() as BubbleTeleport
	if new_bubble == null:
		return
	teleport_bubbles_in_game += 1

func _on_bubble_spawn_timer_timeout() -> void:
	if teleport_bubbles_in_game >= max_bubbles_in_level:
		return
	spawn_new_bubble()
