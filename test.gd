extends Node2D

class_name TurnQueue

onready var entities = $Entities
onready var active_character = $Entities/Player
onready var buttons = $Ui/Buttons
onready var soul = $Entities/Player
onready var box = $BattleBox
onready var Current_menuState = buttons.menuState
onready var menuTextSystem = $"MenuTextSystem/Menu Text For ActnStuff"
onready var ui = $Ui

export var turn = 0
export var menuIndex = 0
export var AttackTurn = 0

signal changeBoxSize(MovementType, x1,x2,y1,y2,speed, Movetype, Easetype, delay)

signal setText(text)
signal clearText

#func _on_Battle_changeBoxSize(MovementType, x1, x2, y1, y2, Movetype = 0, Easetype = 3, speed = 0.5, delay = 0):

func _ready():

	if turn == 0:
		soul.state = 0
		
		buttons.buttonSelection = 0

var setSoulPos = false

func _physics_process(_delta):

		
	menuSystem()
#	if Input.is_action_just_pressed("ui_down"):
#		get_tree().reload_current_scene()

func menuSystem():
	if turn == 0:

		$Entities/Player/CollisionShape2D.disabled = true
		soul.state = 0
	
		match Current_menuState:
			0:
				setText("[*3]don't be alarmed frisk [s2][*4][`4]* we've got this in the bag")
				soul.position = Vector2(buttons.buttons[buttons.buttonSelection].position.x - 37, buttons.buttons[buttons.buttonSelection].position.y)		
			1:
				match menuIndex:
					0:
						soul.position = ui.ItemSoulPos
		
	elif turn == 1:

		if soul.state == 0:
			soul.position = Vector2(320,240)
			soul.state = 1
			$Entities/Player/CollisionShape2D.disabled = false
			
		for i in buttons.buttons:
			i.frame = 0


func setText(text:String):
	emit_signal("setText", text)
	
	
func clearText():
	emit_signal("clearText")

func menuText():
	$MenuTextSystem/RichTextLabel.bbcode_text = "  *"
