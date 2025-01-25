extends CharacterBody2D
class_name BattleMember

var stats = {"hp":1, "str":1, "def":1, "mgk":1, "mgkdef":1, "spd":1}
var curhp
var maxshine
var action
var membername
var ID
var ally
var location : Vector2


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

func takedamage(value):
	if curhp - value < 0:
		curhp = 0
	else:
		curhp -= value
	$ProgressBar.value = curhp

func heal(value):
	if curhp + value > stats["hp"]:
		curhp = stats["hp"]
	else:
		curhp += value
		
func teleport_to_location(destination: Vector2) -> void:
	location = destination

func grabfocus():
	$selecter.show()

func releasefocus():
	$selecter.hide()
