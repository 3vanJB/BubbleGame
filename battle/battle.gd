extends Node2D
#
var m = preload("res://battle/battlemember.tscn")
var hoversound = preload("res://SFX/Bubbles SFX Batch 1/UI/SFX_UI_Hover.wav")
var confirmsound = preload("res://SFX/Bubbles SFX Batch 1/UI/SFX_UI_Confirm.wav")
@onready var playerparty = $playerparty
@onready var enemyparty = $enemyparty
@onready var UI = $UI
@export var echip : int 
@onready var skillbutton = $UI/HBoxContainer/buttonpanel/PanelContainer/VBoxContainer/skill
@onready var buttonattack = $UI/HBoxContainer/buttonpanel/PanelContainer/VBoxContainer/attack
@onready var buttonskill1 = $UI/skillmenu/PanelContainer/VBoxContainer/HBoxContainer/Buttonskill1
@onready var buttonskill2 = $UI/skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill2
@onready var buttonskill3 = $UI/skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill3
@onready var attackname = $UI/attack
#checks to see if targeting enemy
var enemyfocused = false
var partyfocused = false
var nextdamage : int
var last_overworld_locations : Dictionary # THIS is for when going back to overworld. To know where we are going to spawn the characters back to

signal playeractionselected

var turns = []
var current
var intext = false
#MusicManager.currentsong

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if echip == null:
		echip = 0
	Audio.switchtotrack(2)
	Audio.music.play()
	$Camera2D.make_current()
	
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
	enemyparty.mcount = len(enemyparty.members)
	UI.setshine(0, playerparty.members[0].curshine)
	UI.setshine(1, playerparty.members[1].curshine)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	if intext == false:
		nextturn()

func _on_timeline_ended() -> void:
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	nextturn()

func endbattle():
	Changer.AnimPlayer.play("fadein")
	await Changer.AnimPlayer.animation_finished
	Changer.AnimPlayer.play("fadeout")
	get_parent().emit_signal("battleend")
	self.queue_free()
	


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
			UI.nameh.hide()
			UI.setmainbuttons(false)
			enemyparty.endfocus()
		if Input.is_action_just_pressed("ui_accept"):
			Audio.playeffect(confirmsound)
			await get_tree().create_timer(0.1).timeout
			enemyfocused = false
			#print("current.membernamepressed")
			UI.settargettext(current.membername)
			UI.setattacktext(current.action.actionname)
			attackname.show()
			var tar = enemyparty.cursor
			enemyparty.endfocus()
			current.action.loadsoundpath()
			Audio.playeffect(current.action.sound)
			await get_tree().create_timer(1).timeout
			calculate(current, enemyparty.members[tar])
			if enemyparty.members[tar].isko == true:
				enemyparty.dcount += 1
			attackname.hide()
			
			emit_signal("playeractionselected")
			
	if partyfocused == true:
		if Input.is_action_just_pressed("left"):
			playerparty.scrolldown()
			#print(playerparty.cursor)
		if Input.is_action_just_pressed("right"):
			playerparty.scrollup()
			#print(playerparty.cursor)
		if Input.is_action_just_pressed("ui_cancel"):
			partyfocused = false
			buttonattack.grab_focus()
			UI.setmainbuttons(false)
			playerparty.endfocus()
		if Input.is_action_just_pressed("ui_accept"):
			Audio.playeffect(confirmsound)
			await get_tree().create_timer(0.1).timeout
			partyfocused = false
			
			UI.settargettext(current.membername)
			UI.setattacktext(current.action.actionname)
			attackname.show()
			current.action.loadsoundpath()
			Audio.playeffect(current.action.sound)
			
			await get_tree().create_timer(1).timeout
			#print(current.action.actionname)
			calculate(current, playerparty.members[playerparty.cursor])
			playerparty.endfocus()
			enemyparty.endfocus()
			attackname.hide()
			emit_signal("playeractionselected")
	
	
func nextturn():
	
	if enemyparty.dcount == enemyparty.mcount:
		print("theend")
		UI.setmainbuttons(true)
		endbattle()
	
	for i in len(turns):
		
		current = turns[i]
		
		if turns[i].isko == false:
			current.restoreshine(10)
			
			if turns[i].ally == false:
				print("enemyturn")
				#print(turns[i].membername + "'s turn")
				if MEMBERINFO.members[current.ID].has("skills"):
					print("skills")
					
				
				turns[i].action = regatk
				calculate(turns[i], playerparty.members[1])
			else:
				if current.ID == 0:
					UI.setshine(0, playerparty.members[0].curshine)
				else:
					UI.setshine(1, playerparty.members[1].curshine)
				UI.loadskills(turns[i].ID)
				UI.setmainbuttons(false)
				UI.setskillbuttons(false)
				current = turns[i]
				#print(turns[i].membername + "'s turn")
				buttonattack.grab_focus()
				
				if enemyparty.dcount == enemyparty.mcount:
					UI.setmainbuttons(true)
					endbattle()
					return
				else:
					await playeractionselected
				
				UI.nameh.hide()
		else:
			print(len(enemyparty.members))
			if len(enemyparty.members) == 0:
				print("theend")
				UI.setmainbuttons(true)
				endbattle()
	
	attackname.hide()
	nextturn()

func calculate(attacker, target):
	#print(str(attacker) + "12435")
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
			var damage = (((attacker.curshine/50 * attacker.stats["str"]) - (target.curshine/50 * target.stats["def"]))) * attacker.action.power
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
		#print("cheer")
		playerparty.members[0].restoreshine(attacker.action.cheervalue)
		playerparty.members[1].restoreshine(attacker.action.cheervalue)
		UI.setshine(0, playerparty.members[0].curshine)
		UI.setshine(1, playerparty.members[1].curshine)
	elif attacker.action.isheal == true:
		var healing = attacker.stats["mgk"] * attacker.action.power
		target.heal(healing)
		UI.sethplabel(target.ID, target.curhp)
		#print(target.membername + "653728")
	UI.setattacktext(current.action.actionname)

var regatk = preload("res://battle/actions/RegAttack.tres")
func _on_attack_pressed() -> void:
	print(enemyparty.dcount == enemyparty.mcount)
	UI.setmainbuttons(true)
	enemyfocused = true
	Audio.playeffect(confirmsound)
	current.action = regatk
	enemyparty.grabfocus(0)
	
	print(current.membername)
	UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
	UI.nameh.show()
	buttonattack.release_focus()
	
func transition_to_overworld() -> void:
	# TODO: transition back to overworld
	pass


func _on_skill_pressed() -> void:
	UI.skillmenu.show()
	UI.setmainbuttons(true)
	buttonattack.disabled = true
	buttonskill1.grab_focus()


func _on_buttonskill_1_pressed() -> void:
	if UI.skill1.cost > current.curshine:
		pass
	Audio.playeffect(confirmsound)
	await get_tree().create_timer(0.1).timeout
	UI.setskillbuttons(true)
	UI.skillmenu.hide()
	current.action = UI.skill1
	if UI.skill1.targetenemyparty == true:
		UI.setattacktext(current.action.actionname)
		attackname.show()
		current.action.loadsoundpath()
		Audio.playeffect(current.action.sound)
		
		UI.skillmenu.hide()
		await get_tree().create_timer(1).timeout
		for i in len(enemyparty.members):
			calculate(current, enemyparty.members[i])
			if enemyparty.members[i].isko == true:
				enemyparty.dcount += 1
		attackname.hide()
		emit_signal("playeractionselected")
		
	else:
		
		UI.nameh.show()
		UI.skillmenu.hide()
		enemyparty.grabfocus(0)
		enemyfocused = true
		UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
		UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
	UI.setattacktext(current.action.actionname)
	buttonskill1.release_focus()


func _on_skill_2_pressed() -> void:
	Audio.playeffect(confirmsound)
	await get_tree().create_timer(0.1).timeout
	UI.setskillbuttons(true)
	UI.skillmenu.hide()
	if UI.skill2.targetallyparty == true:
		current.action = UI.skill2
		current.action.loadsoundpath()
		Audio.playeffect(current.action.sound)
		
		UI.setattacktext(current.action.actionname)
		attackname.show()
		attackname.show()
		await get_tree().create_timer(1).timeout
		calculate(current, current)
		attackname.hide()
		emit_signal("playeractionselected")
		
	elif UI.skill2.isheal == true:
		partyfocused = true
		UI.skillmenu.hide()
		playerparty.grabfocus(0)
	
	
	current.action = UI.skill2
	UI.setattacktext(current.action.actionname)
	buttonskill2.release_focus()




func _on_skill_3_pressed() -> void:
	Audio.playeffect(confirmsound)
	await get_tree().create_timer(0.1).timeout
	UI.setskillbuttons(true)
	UI.skillmenu.hide()
	#print(UI.skill3.actionname +"skill3")
	current.action = UI.skill3
	if UI.skill3.targetenemyparty == true:
		UI.setattacktext(current.action.actionname)
		
		current.action.loadsoundpath()
		Audio.playeffect(current.action.sound)
		attackname.show()
		
		await get_tree().create_timer(1).timeout
		for i in len(enemyparty.members):
			calculate(current, enemyparty.members[i])
			if enemyparty.members[i].isko == true:
				enemyparty.dcount += 1
		attackname.hide()
		emit_signal("playeractionselected")
		
	else:
		enemyparty.grabfocus(0)
		enemyfocused = true
		UI.nameh.show()
		UI.skillmenu.hide()
		
		UI.settargettext(enemyparty.members[enemyparty.cursor].membername)
		
	UI.skillmenu.hide()
	
	buttonskill3.release_focus()
