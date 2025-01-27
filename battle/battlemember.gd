extends CharacterBody2D
class_name BattleMember

var stats = {"hp":1, "str":1, "def":1, "mgk":1, "mgkdef":1, "spd":1}
var curhp : int
var maxshine : float = 100.0
var curshine : float = 0
var action
var membername
var ID
var ally
var isko = false
# TODO: make a function that decides the target of the enemy

func setup():
	stats = MEMBERINFO.getmemberstats(ID)
	curhp = stats["hp"]
	ally = MEMBERINFO.getmember(ID)["ally"]
	membername = MEMBERINFO.getmember(ID)["name"]
	$ProgressBar.max_value = stats["hp"]
	if ally == true:
		curhp = MEMBERINFO.partyhp[ID]
		hide()
	else:
		#print(MEMBERINFO.members[ID])
		var s = load(MEMBERINFO.members[ID]["sprite"])
		s = s.instantiate()
		add_child(s)
	$ProgressBar.value = curhp
	curshine = 10

func takedamage(value):
	if curhp - value < 0:
		curhp = 0
	else:
		curhp -= value
	$ProgressBar.value = curhp
	if curhp == 0:
		ko()

func restoreshine(value):
	if curshine + value > maxshine:
		curshine = maxshine
	else:
		curshine += value

func consumeshine(value):
	if curshine - value < 0:
		curshine = 0
	else:
		curshine -= value

func heal(value):
	if curhp + value > stats["hp"]:
		curhp = stats["hp"]
	else:
		curhp += value

func ko():
	isko = true
	if ally == false:
		$AnimationPlayer.play("death")
		await $AnimationPlayer.animation_finished
		get_parent().removefromarray()
		



func grabfocus():
	$selecter.show()

func releasefocus():
	$selecter.hide()
