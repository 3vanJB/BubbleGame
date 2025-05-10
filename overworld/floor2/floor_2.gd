extends Node2D
var b = preload("res://battle/battle.tscn") # Access battle library of encounters
var bsound = preload("res://Audio/Battle Start.wav")
var current_character_controlled_index : int = 0
var prevbattle
var battle
signal battleend

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.switchtotrack(1)

func transition_to_battle(echip, istext) -> void:
	var n = b.instantiate() #Root of borrowing
	n.echip = echip #Dictionary Ranges 0 to 1
	n.name = "battle"
	prevbattle = echip
	n.intext = istext
	$PlayerCharacter1.frozen = true
	#$Lights.hide()
	Changer.AnimPlayer.play("fadein")
	Audio.playeffect(bsound)
	await get_tree().create_timer(3).timeout
	add_child(n)
	#$TileMapLayer.hide()
	#$TileMapLayer2.hide()
	#$PlayerCharacter1.hide()
	Changer.AnimPlayer.play("fadeout")
	await Changer.AnimPlayer.animation_finished
	battle = $battle
	
func exitbattle():
	Audio.music.stream = load(Audio.tracks[1])
	Audio.music.play()
	#$Lights.show()
	$PlayerCharacter1.frozen = false
	$PlayerCharacter1/Camera2D.make_current()
	
#Dialogue Encounters
func _on_entrance_body_entered(body: Node2D) -> void:
	$Dialogue/Entrance.queue_free()
	if body.is_in_group("controller"):
		#Dialogic.timeline_ended.connect(_on_timeline_ended)
		$PlayerCharacter1.frozen = true
		Dialogic.start("Second Entrance")
		await Dialogic.timeline_ended
		$PlayerCharacter1.frozen = false
func _on_first_portal_body_entered(body: Node2D) -> void:
	$"Dialogue/First Portal".queue_free()
	if body.is_in_group("controller"):
		#Dialogic.timeline_ended.connect(_on_timeline_ended)
		$PlayerCharacter1.frozen = true
		Dialogic.start("Encounter Portal")
		await Dialogic.timeline_ended
		$PlayerCharacter1.frozen = false

func _on_enemy_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("controller"):
		#Dialogic.timeline_ended.connect(_on_timeline_ended)
		$PlayerCharacter1.frozen = true
		#Dialogic.start("Pre Battle 1")
		#await Dialogic.timeline_ended
		Audio.switchtotrack(2)
		transition_to_battle(4, false)
		#Dialogic.start("Battle 1")
		$"Triggers/Enemy_1".queue_free()
		await battleend
		exitbattle()


func _on_enemy_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("controller"):
		#Dialogic.timeline_ended.connect(_on_timeline_ended)
		$PlayerCharacter1.frozen = true
		#Dialogic.start("Pre Battle 1")
		#await Dialogic.timeline_ended
		Audio.switchtotrack(2)
		transition_to_battle(5, false)
		#Dialogic.start("Battle 1")
		$"Triggers/Enemy_2".queue_free()
		await battleend
		exitbattle()


func _on_boss_room_body_entered(body: Node2D) -> void:
	if body.is_in_group("controller"):
		Changer.start_transition("res://overworld/floor2/boss_room.tscn")
