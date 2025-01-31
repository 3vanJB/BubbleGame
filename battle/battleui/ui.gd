extends CanvasLayer

var skill1
var skill2
var skill3
@onready var skillmenu = $skillmenu
@onready var attackh = $attack
@onready var nameh = $target


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if MEMBERINFO.hasyoru == false:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/member2.hide()
	$skillmenu.hide()
	

func sethplabel(ID, cur):
	if ID == 0:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/VBoxContainer2/memeber1/hp.text = str(cur) + "/" + str(MEMBERINFO.getmemberstats(ID)["hp"])
	else:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/VBoxContainer/member2/hp.text = str(cur) + "/" + str(MEMBERINFO.getmemberstats(ID)["hp"])

func setshine(ID, cur):
	if ID == 0:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/VBoxContainer2/shine.value = cur
	else:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/VBoxContainer/shine.value = cur

#enables/disables main buttons
func setmainbuttons(value: bool):
	for i in len($HBoxContainer/buttonpanel/PanelContainer/VBoxContainer.get_children()):
		$HBoxContainer/buttonpanel/PanelContainer/VBoxContainer.get_children()[i].disabled = value
#enables /disbales skill buttons
func setskillbuttons(value: bool):
	$skillmenu/PanelContainer/VBoxContainer/HBoxContainer/Buttonskill1.disabled = value
	$skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill2.disabled = value
	$skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill3.disabled = value

func grabmemberfocus(value):
	if value == 0:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/VBoxContainer2/memeber1/icon.show()
	else:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/VBoxContainer/member2/icon.show()
func releasememberfocus(value):
	if value == 0:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/VBoxContainer2/memeber1/icon.hide()
	else:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/VBoxContainer/member2/icon.hide()

func loadskills(ID):
	if ID == 0:
		skill1 = load(ACTIONS.actions[1])
		skill2 = load(ACTIONS.actions[2])
		skill3 = load(ACTIONS.actions[3])
		
		$skillmenu/PanelContainer/VBoxContainer/HBoxContainer/Buttonskill1.text = skill1.actionname
		$skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill2.text = skill2.actionname
		$skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill3.text = skill3.actionname
	else:
		skill1 = load(ACTIONS.actions[4])
		skill2 = load(ACTIONS.actions[5])
		skill3 = load(ACTIONS.actions[6])
		$skillmenu/PanelContainer/VBoxContainer/HBoxContainer/Buttonskill1.text = skill1.actionname
		$skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill2.text = skill2.actionname
		$skillmenu/PanelContainer/VBoxContainer/HBoxContainer2/skill3.text = skill3.actionname

func setattacktext(text):
	$attack/MarginContainer/attackname/HBoxContainer/Label.text = text
func settargettext(text):
	$target/MarginContainer/attackname/HBoxContainer/Label.text = text
