extends CanvasLayer

export var Active = true
export var Destroy = false

#instation menus
onready var Debug = $Debug

#calling values ahead
onready var battle = get_node("..")
onready var soul = get_node("../Entities/Player")

func _process(delta):
	
	for i in get_children():
		i.visible = Active
	Debug.bbcode_text = "[rainbow]turn = " + str(battle.turn) + "\n" + "MenuIndex = " + str(battle.menuIndex) + "\n" + "AttackTurn = " + str(battle.AttackTurn) + "\n" + "state = " + str(soul.state)
func _ready():

	
	if Destroy == true:
		for i in get_children():
			i.queue_free()
