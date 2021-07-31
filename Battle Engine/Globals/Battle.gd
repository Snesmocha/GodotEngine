extends Node2D

var monster = EnemyStorage.sans 

onready var buttons = $Ui/Buttons
onready var menutext = $TextEngine/RichTextLabel
onready var box = $BattleBox
onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready():
	print(monster)
	menutext.showDialogue("this is your first encounter\n  don't screw it up",[31],[0.8])
	player.state = 0

var timer = 0



func _on_item_playerPosition(pos):
	player.position = pos


func _on_Buttons_playerPos(pos):
	player.position = pos
