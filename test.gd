extends Node2D

class_name TurnQueue

onready var entities = $Entities
onready var active_character = $Entities/Player
onready var buttons = $Ui/Buttons
onready var soul = $Entities/Player
onready var box = $BattleBox
onready var menuTextSystem = $"MenuTextSystem/Menu Text For ActnStuff"
onready var ui = $Ui
onready var ItemPos = [
	Vector2(72, 289),
	Vector2(312, 289),
	Vector2(72, 323),
	Vector2(312, 323)
]

export var menuState = 0
export var turn = 0
export var itemIndex = 0
export var AttackTurn = 0

signal setText(text)
signal clearText



#func _on_Battle_changeBoxSize(MovementType, x1, x2, y1, y2, Movetype = 0, Easetype = 3, speed = 0.5, delay = 0):

func _ready():

	if turn == 0:
		soul.state = 0
		
		buttons.buttonSelection = 0

var setSoulPos = false
var tempTimer = 0

func _physics_process(delta):
	print([menuState, buttons.buttonSelection])
	menuSystem()
#forgot to comment the fucking code, so ummmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm yeah- 
# i think this handles the menu, ik turn 0 is your turn and turn one is enemy turn, though i could change to a bool


func menuSystem():
	if turn == 0:

		$Entities/Player/CollisionShape2D.disabled = true
		soul.state = 0
		#this is actually for disabling text shit?
		match menuState:
			0:
				setText("[*3]don't be alarmed frisk [s2][*4][`4]  we've got this in the bag :)")
				soul.position = Vector2(buttons.buttons[buttons.buttonSelection].position.x - 37, buttons.buttons[buttons.buttonSelection].position.y)		
			1:
				clearText()
					
			2: #act system
				clearText()
			
			3: #item
				clearText()
				itemSystem()
				
			4: #mercy system
				clearText()
				


				
	elif turn == 1:
		emit_signal("clearText")
		if soul.state == 0:
			soul.position = Vector2(320,240)
			soul.state = 1
			$Entities/Player/CollisionShape2D.disabled = false
			
		for i in buttons.buttons:
			i.frame = 0

func interact():
	match buttons.buttonSelection:
		0:
			pass
		1:
			pass
		2:
			if Input.is_action_just_pressed("ui_accept"):
				menuState = buttons.buttonSelection + 1
		3: 
			pass


func setText(text:String):
	emit_signal("setText", text)

	
func clearText():
	emit_signal("clearText")

func menuText():
	$MenuTextSystem/RichTextLabel.bbcode_text = "  *"
	
	
func itemSystem():

	for i in buttons.buttons:
		i.frame = 0
	if Input.is_action_just_pressed("ui_left"):
		itemIndex -= 1
	elif Input.is_action_just_pressed("ui_right"):
		itemIndex += 1
	elif Input.is_action_just_pressed("ui_up"):
		itemIndex -= 2
	elif Input.is_action_just_pressed("ui_down"):
		itemIndex += 2
				
	if itemIndex < 0:
		itemIndex = 0
	elif itemIndex > 3:
		itemIndex = 0
	soul.position = ItemPos[itemIndex]
