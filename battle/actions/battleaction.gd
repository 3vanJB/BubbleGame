extends Resource
class_name BattleAction

#0 is phys attack, 1 is magick
@export var type : int
@export var isattack : bool
@export var power: float
@export var cost : float
@export var actionname : String
@export var targetenemy: bool = true
@export var ischeer : bool = false
@export var cheervalue : int = 20
@export var targetally : bool = false
@export var targetallyparty: bool = false
@export var targetenemyparty : bool = false
@export var isspecial : bool = false
@export var isheal : bool = false
