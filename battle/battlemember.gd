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


func setup():
	stats = MEMBERINFO.getmemberstats(ID)
	curhp = stats["hp"]
	ally = MEMBERINFO.getmember(ID)["ally"]
	membername = MEMBERINFO.getmember(ID)["name"]
	$ProgressBar.max_value = stats["hp"]
	if ally == true:
		curhp = MEMBERINFO.partyhp[ID]
		hide()
	$ProgressBar.value = curhp
	curshine = 25

func takedamage(value):
	if curhp - value < 0:
		curhp = 0
	else:
		curhp -= value
	$ProgressBar.value = curhp

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

func grabfocus():
	$selecter.show()

func releasefocus():
	$selecter.hide()
