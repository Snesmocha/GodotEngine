extends Node2D


onready var buttons = []

export var buttonSelection = 0

func _ready():
	for i in get_children():
		buttons.append(i)

	print(buttons)

func _physics_process(delta):
	setSelection(buttonSelection)
	interaction()




func interaction():
	if Input.is_action_just_pressed("ui_left"):
		buttonSelection -= 1
	elif Input.is_action_just_pressed("ui_right"):
		buttonSelection += 1
		
	if buttonSelection < 0:
		buttonSelection = 3
	if buttonSelection > 3:
		buttonSelection = 0

func setSelection(current):
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