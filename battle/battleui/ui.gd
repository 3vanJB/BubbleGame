extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if MEMBERINFO.hasyoru == false:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/member2.hide()
	

func sethplabel(ID, cur):
	if ID == 0:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/memeber1/hp.text = str(cur) + "/" + str(MEMBERINFO.getmemberstats(ID)["hp"])
	else:
		$HBoxContainer/memberpanel/PanelContainer/VBoxContainer/member2/hp.text = str(cur) + "/" + str(MEMBERINFO.getmemberstats(ID)["hp"])
