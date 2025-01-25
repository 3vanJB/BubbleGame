extends Node2D
#
var m = preload("res://battle/battlemember.tscn")
@onready var playerparty = $playerparty
@onready var enemyparty = $enemyparty
@onready var UI = $UI
@export var echip : int = 0
@onready var buttonattack = $UI/HBoxContainer/buttonpanel/PanelContainer/VBoxContainer/attack
#checks to see if targeting enemy
var enemyfocused = false
var nextdamage : int
var last_overworld_locations : Dictionary # THIS is for when going back to overworld. To know where we are going to spawn the characters back to

signal playeractionselected
var turns = []
var current

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
	UI.setshine(0, playerparty.members[0].curshine)
	UI.setshine(1, playerparty.members[1].curshine)
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
			calculate(turns[i], playerparty.members[1])
		else:
			UI.loadskills(turns[i].ID)
			buttonattack.disabled = false
			#print(turns[i].membername + "'s turn")
			buttonattack.grab_focus()
			await playeractionselected
	nextturn()

func calculate(attacker, target):
	if attacker.action.isattack == true:
		var damage = (((attacker.curshine/50 * attacker.stats["str"]) - (target.curshine/50 * target.stats["def"]))) * attacker.action.power
		damage += randi_range(-2, 2)
		if damage < 0:
			damage = 1
		nextdamage = damage
		target.takedamage(damage)
		if target.ally == true:
			UI.sethplabel(target.ID, target.curhp)
		print(nextdamage)


func _on_attack_pressed() -> void:
	buttonattack.disabled = true
	enemyfocused = true
	enemyparty.grabfocus(0)
	current.action = load(ACTIONS.actions[0])
	buttonattack.release_focus()
	
func transition_to_overworld() -> void:
	# TODO: transition back to overworld
	get_tree().change_scene_to_file("res://overworld/overworld_level.tscn")
	pass


func _on_skill_pressed() -> void:
	UI
