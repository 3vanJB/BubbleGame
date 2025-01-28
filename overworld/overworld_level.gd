extends Node2D

var b = preload("res://battle/battle.tscn") # Access battle library of encounters
var current_character_controlled_index : int = 0
var enemy_dead = 0
var gate
var bossgate
var prevbattle
@onready var req = $"Gate/Text/Requirement Text"
# var player_characters : Array[PlayerCharacter] = []
var battle
signal battleend
func _ready() -> void:
	
	Audio.switchtotrack(1)
	Dialogic.timeline_ended.connect(_on_entrance_ended)
	$PlayerCharacter1.frozen = true
	Dialogic.start("First Entrance")
	#Dialogic.start("Quick_start")


func _on_entrance_ended() -> void:
	Dialogic.timeline_ended.disconnect(_on_entrance_ended)
	$PlayerCharacter1.frozen = false


func spawn_new_bubble() -> void:

	# var new_bubble : BubbleTeleport = load("res://battle/teleport bubble/bubble_teleport.tscn").instantiate() as BubbleTeleport

	var new_bubble : BubbleTeleport = load("res://misc/teleport bubble/bubble_teleport.tscn").instantiate() as BubbleTeleport
	add_child(new_bubble)
	new_bubble.global_position = get_random_location_around_one_player()
	if new_bubble == null:
		return

func _on_bubble_spawn_timer_timeout() -> void:
	spawn_new_bubble()

func exitbattle():
	Audio.music.stream = load(Audio.tracks[1])
	Audio.music.play()
	$PlayerCharacter1.frozen = false
	$PlayerCharacter1/Camera2D.make_current()


func transition_to_battle(echip, istext) -> void:
	var n = b.instantiate() #Root of borrowing
	n.echip = echip #Dictionary Ranges 0 to 1
	n.name = "battle"
	prevbattle = echip
	n.intext = istext
	$PlayerCharacter1.frozen = true
	Changer.AnimPlayer.play("fadein")
	await Changer.AnimPlayer.animation_finished
	add_child(n)
	#$TileMapLayer.hide()
	#$TileMapLayer2.hide()
	#$PlayerCharacter1.hide()
	Changer.AnimPlayer.play("fadeout")
	await Changer.AnimPlayer.animation_finished
	battle = $battle

func _on_timeline_ended() -> void:
	#Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	#var n = b.instantiate()
	#n.echip = 0
	#$PlayerCharacter1.frozen = true
	#Changer.AnimPlayer.play("fadein")
	#await Changer.AnimPlayer.animation_finished
	#add_child(n)
	#$TileMapLayer.hide()
	##$TileMapLayer2.hide()
	#$PlayerCharacter1.hide()
	#Changer.AnimPlayer.play("fadeout")
	#await Changer.AnimPlayer.animation_finished
	pass

func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("Escape"):
		#$SceneChanger.start_transition("res://Options_UI.tscn")
	pass

func get_random_location_around_one_player() -> Vector2:
	var character : PlayerCharacter = Auto.overworld_characters.pick_random()
	var x : float = randf_range(300, 400)
	var y : float = randf_range(100, 150)
	return Vector2(character.global_position.x + ((x * 1) if randi() % 2 == 0 else (x * -1)), character.global_position.y + ((x * 1) if randi() % 2 == 0 else (x * -1)))

func _on_bosstrigger_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("controller"):
		print("boss")
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		$PlayerCharacter1.frozen = true
		Dialogic.start("preboss")
		await Dialogic.timeline_ended
		transition_to_battle(1,false)
		$bosstrigger.queue_free()
		#await $battle.battleend
		#exitbattle()

func setgatevalues(value):
	#print("Value is ",str(value))
	#gate = value
	#bossgate = value
	if value < 3:
		$"BossGate/Text/Out of".text = str(value) + "/" + "3"
	if value < 2:
		$"Gate/Text/Out of".text = str(value) + "/" + "2"
	if value == 2:
		$Gate.queue_free()
	if value == 3:
		$BossGate.queue_free()



#NOTE Number corresponds to fight ID and not chronological order
func _on_battleend() -> void:
	exitbattle()
	print("worlbattlened")
	enemy_dead += 1
	setgatevalues(enemy_dead)
	await Changer.AnimPlayer.animation_finished
	match prevbattle:
		0:
			Dialogic.start("Post Battle 1")
		3:
			Dialogic.start("Post Battle 2")
		2:
			Dialogic.start("Post Battle 3")

#JANK- Multiple ENEMY_TRIGGERs to deal with death of each of them

func _on_enemy_trigger_2_body_entered(body: Node2D) -> void:
	#Apparently has "faith type" enemy
	if body.is_in_group("controller"):
		#Dialogic.timeline_ended.connect(_on_timeline_ended)
		
		$PlayerCharacter1.frozen = true
		Dialogic.start("Pre Battle 2")
		await Dialogic.timeline_ended
		transition_to_battle(3, true)
		Dialogic.start("Battle 2")
		
		#Dealing with multiple instances of different Enemy Trigger
		#Because I'm too lazy to make another function.
		$"Enemy Trigger2".queue_free()
		#await battleend

func _on_enemy_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("controller"):
		#Dialogic.timeline_ended.connect(_on_timeline_ended)
		$PlayerCharacter1.frozen = true
		Dialogic.start("Pre Battle 1")
		await Dialogic.timeline_ended
		transition_to_battle(0, true)
		Dialogic.start("Battle 1")
		
		$"Enemy Trigger".queue_free()
		#await battleend

func _on_enemy_trigger_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("controller"):
		#Dialogic.timeline_ended.connect(_on_timeline_ended)
		$PlayerCharacter1.frozen = true
		Dialogic.start("Pre Battle 3")
		await Dialogic.timeline_ended
		transition_to_battle(2, false)
		#Dialogic.start("Post Battle 3")
		
		#Dealing with multiple instances of different Enemy Trigger
		#Because I'm too lazy to make another function.
		$"Enemy Trigger3".queue_free()
		#await battleend
