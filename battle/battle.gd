extends Node2D
#
var m = preload("res://battle/battlemember.tscn")
@onready var playerparty = $playerparty
@onready var enemyparty = $enemyparty
@onready var UI = $UI
@export var echip : int = 0
@onready var skillbutton = $UI/HBoxContainer/buttonpanel/PanelContainer/VBoxContainer/skill
@onready var buttonattack = $UI/HBoxContainer/buttonpanel/PanelContainer/VBoxContainer/attack
@onready var buttonskill1 = $UI/skillmenu/PanelContainer/VBoxContainer/HBoxContainer/Buttonskill1
@onready var buttonskill2 = $UI/skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill2
@onready var buttonskill3 = $UI/skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill3
#checks to see if targeting enemy
var enemyfocused = false
var partyfocused = false
var nextdamage : int
var last_overworld_locations : Dictionary # THIS is for when going back to overworld. To know where we are going to spawn the characters back to

signal playeractionselected
var turns = []
var current

#MusicManager.currentsong

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI.setmainbuttons(true)
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
			UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
		if Input.is_action_just_pressed("right"):
			enemyparty.scrollup()
			UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
		if Input.is_action_just_pressed("ui_cancel"):
			enemyfocused = false
			buttonattack.grab_focus()
			UI.setmainbuttons(false)
			enemyparty.endfocus()
		if Input.is_action_just_pressed("ui_accept"):
			enemyfocused = false
			print("current.membernamepressed")
			calculate(current, enemyparty.members[enemyparty.cursor])
			enemyparty.endfocus()
			emit_signal("playeractionselected")
	if partyfocused == true:
		if Input.is_action_just_pressed("left"):
			playerparty.scrolldown()
			print(playerparty.cursor)
		if Input.is_action_just_pressed("right"):
			playerparty.scrollup()
			print(playerparty.cursor)
		if Input.is_action_just_pressed("ui_cancel"):
			partyfocused = false
			buttonattack.grab_focus()
			UI.setmainbuttons(false)
			playerparty.endfocus()
		if Input.is_action_just_pressed("ui_accept"):
			partyfocused = false
			print(current.membername)
			calculate(current, playerparty.members[playerparty.cursor])
			playerparty.endfocus()
			enemyparty.endfocus()
			emit_signal("playeractionselected")

func nextturn():
	for i in len(turns):
		current = turns[i]
		current.restoreshine(15)
		if turns[i].ally == false:
			
			#print(turns[i].membername + "'s turn")
			turns[i].action = load(ACTIONS.actions[0])
			##THIS IS THE PART THAT DECIDES WHICH ACTION TO USE
			calculate(turns[i], playerparty.members[1])
		else:
			UI.loadskills(turns[i].ID)
			UI.setmainbuttons(false)
			UI.setskillbuttons(false)
			current = turns[i]
			print(turns[i].membername + "'s turn")
			buttonattack.grab_focus()
			await playeractionselected
			UI.nameh.hide()
	nextturn()

func calculate(attacker, target):
	print(attacker.action.actionname  + "action")
	if attacker.action.isattack == true:
		if attacker.action.isspecial == true:
			if attacker.action.type == 0:
				var damage = attacker.curshine/50 * (attacker.stats["str"] * attacker.action.power) - target.curshine/50 * target.stats["def"]
				damage += randi_range(-2, 2)
				if damage < 0:
					damage = 1
				nextdamage = damage
			else:
				var damage = attacker.curshine/50 * (attacker.stats["mgk"] * attacker.action.power) - target.curshine/50 * target.stats["mgkdef"]
				damage += randi_range(-2, 2)
				if damage < 0:
					damage = 1
				nextdamage = damage
		if attacker.action.targetenemyparty == true and attacker.ally == false:
			if attacker.action.type == 0:
				var damage = (((attacker.curshine/50 * attacker.stats["str"]) - (target.curshine/50 * target.stats["def"]))) * attacker.action.power
				damage += randi_range(-2, 2)
				if damage < 0:
					damage = 1
				nextdamage = damage
				playerparty.members[0].takedamage(nextdamage)
				playerparty.members[1].takedamage(nextdamage)
			else:
				var damage = (((attacker.curshine/50 * attacker.stats["mgk"]) - (target.curshine/50 * target.stats["mgkdef"]))) * attacker.action.power
				damage += randi_range(-2, 2)
				if damage < 0:
					damage = 1
				nextdamage = damage
				playerparty.members[0].takedamage(nextdamage)
				playerparty.members[1].takedamage(nextdamage)
		
		if attacker.action.type == 0:
			var damage = (((attacker.curshine/50 * attacker.stats["str"]) - (target.curshine/50 * target.stats["def"]))) * attacker.action.power
			damage += randi_range(-2, 2)
			if damage < 0:
				damage = 1
			nextdamage = damage
			target.takedamage(damage)
			if target.ally == true:
				UI.sethplabel(target.ID, target.curhp)
			#print(nextdamage)
		else:
			var damage = (((attacker.curshine/50 * attacker.stats["mgk"]) - (target.curshine/50 * target.stats["mgkdef"]))) * attacker.action.power
			damage += randi_range(-2, 2)
			if damage < 0:
				damage = 1
			nextdamage = damage
			target.takedamage(damage)
			if target.ally == true:
				UI.sethplabel(target.ID, target.curhp)
			#print(nextdamage)
			
	elif attacker.action.ischeer == true:
		print("cheer")
		playerparty.members[0].restoreshine(attacker.action.cheervalue)
		playerparty.members[1].restoreshine(attacker.action.cheervalue)
		UI.setshine(0, playerparty.members[0].curshine)
		UI.setshine(1, playerparty.members[1].curshine)
	elif attacker.action.isheal == true:
		var healing = attacker.stats["mgk"] * attacker.action.power
		if attacker.ally == false:
			target.heal(healing)
		else:
			target.heal(healing)
			UI.sethplabel(target.ID, target.curhp)
		print(target.membername + "653728")


func _on_attack_pressed() -> void:
	UI.setmainbuttons(true)
	enemyfocused = true
	
	enemyparty.grabfocus(0)
	current.action = load(ACTIONS.actions[0])
	UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
	UI.nameh.show()
	buttonattack.release_focus()
	
func transition_to_overworld() -> void:
	# TODO: transition back to overworld
	get_tree().change_scene_to_file("res://overworld/overworld_level.tscn")
	pass


func _on_skill_pressed() -> void:
	UI.skillmenu.show()
	UI.setmainbuttons(true)
	buttonattack.disabled = true
	buttonskill1.grab_focus()


func _on_buttonskill_1_pressed() -> void:
	UI.setskillbuttons(true)
	current.action = UI.skill1
	if UI.skill1.targetenemyparty == true:
		for i in len(enemyparty.members):
			calculate(current, enemyparty.members[i])
		UI.skillmenu.hide()
		
		emit_signal("playeractionselected")
		
	else:
		
		UI.nameh.show()
		UI.skillmenu.hide()
		enemyparty.grabfocus(0)
		enemyfocused = true
		UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
		UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
	
	buttonskill1.release_focus()


func _on_skill_2_pressed() -> void:
	UI.setskillbuttons(true)
	if UI.skill2.targetallyparty == true:
		current.action = UI.skill2
		calculate(current, current)
		emit_signal("playeractionselected")
		
	elif UI.skill2.isheal == true:
		partyfocused = true
		UI.skillmenu.hide()
		playerparty.grabfocus(0)
	
	UI.skillmenu.hide()
	current.action = UI.skill2
	buttonskill2.release_focus()




func _on_skill_3_pressed() -> void:
	UI.setskillbuttons(true)
	print(UI.skill3.actionname +"skill3")
	current.action = UI.skill3
	if UI.skill3.targetenemyparty == true:
		for i in len(enemyparty.members):
			calculate(current, enemyparty.members[i])
		emit_signal("playeractionselected")
	else:
		enemyparty.grabfocus(0)
		enemyfocused = true
		UI.nameh.show()
		UI.skillmenu.hide()
		
		UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
	UI.skillmenu.hide()
	buttonskill3.release_focus()
