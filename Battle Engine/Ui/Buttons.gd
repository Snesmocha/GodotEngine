extends Node2D


onready var buttons = []
onready var battle = get_node("../../")

export var buttonSelection = 0
export var enabled = false

signal playerPos(pos)
signal button(type)


func _ready():
	for i in get_children():
		buttons.append(i)



func _process(_delta):
	setSelection(buttonSelection)
	
	
	
	
func setSelection(current):
	var ButtonInput = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
	for i in buttons:
		i.frame = 0
		
	match current:
		0:
			buttons[buttonSelection].frame = 1
		1:
			buttons[buttonSelection].frame = 1
		2:
			buttons[buttonSelection].frame = 1
		3:
			buttons[buttonSelection].frame = 1
			
	if enabled:
		buttonSelection = posmod(buttonSelection + ButtonInput, buttons.size())
		emit_signal("playerPos",Vector2(buttons[buttonSelection].position.x - 38, buttons[buttonSelection].position.y))
		if Input.is_action_just_released("ui_accept"):
			enabled = false
			emit_signal("button",buttonSelection)
			
			
		
	else:
		buttonSelection = -1



func _on_item_back(value):
	buttonSelection = value
	enabled = true
	battle.menutext.showDialogue("this is your first encounter\n  don't screw it up",[31],[0.8])
