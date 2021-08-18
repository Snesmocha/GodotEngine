extends Node2D

var monster = EnemyStorage.sans 

onready var buttons = $Ui/Buttons
onready var menutext = $TextEngine/RichTextLabel
onready var box = $BattleBox
onready var player = $Player
onready var entities = $Entities

var enemies = []


const textEngine = preload("res://System/textEngine/TextEngine.tscn")

func createText(showText:String = "eatShoes", pos:Vector2 = Vector2(0,0), margin=[60,275,602,387]):
	var engine = textEngine.instance()
	engine.follow_viewport_enable = true
	engine.layer = 2
	engine.get_node("Node2D").position = pos
	
	engine.get_node("Node2D/RichTextLabel").margin_top = margin[1]
	engine.get_node("Node2D/RichTextLabel").margin_bottom = margin[3]
	engine.get_node("Node2D/RichTextLabel").margin_left = margin[0]
	engine.get_node("Node2D/RichTextLabel").margin_right = margin[2]
	
	engine.text = [showText]
	self.add_child(engine)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_child_count())
#	createText("* killMekillMekillMekillMekillMekillMekillMekillMekillMekillMekillMekillMekillMekillMekillMekillMekillMekillMekillMe")
	print(monster)
#	player.state = 0
	monsters()

func monsters():
	for i in entities.get_children():
		enemies.append(i)
		print(enemies)


func _on_item_playerPosition(pos):
	player.position = pos

func _on_Buttons_playerPos(pos):
	player.position = pos
