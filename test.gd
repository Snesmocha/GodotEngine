extends Node2D

class_name TurnQueue

onready var entities = $Entities
onready var active_character = $Entities/Player
onready var buttons = $Ui/Buttons
onready var soul = $Entities/Player
onready var box = $BattleBox

export var turn = 0



func _ready():
	
	if turn == 0:
		soul.state = 0
		
		buttons.buttonSelection = 0
		soul.position = Vector2(buttons.buttons[buttons.buttonSelection].position.x - 37, buttons.buttons[buttons.buttonSelection].position.y + 2)


func _physics_process(delta):
	if turn == 0:
		soul.position = Vector2(buttons.buttons[buttons.buttonSelection].position.x - 37, buttons.buttons[buttons.buttonSelection].position.y + 2)
