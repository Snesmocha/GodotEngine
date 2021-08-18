extends Sprite

onready var battle = get_node("../../../")
onready var SoulPos = [
	Vector2(72, 289),
	Vector2(312, 289),
	Vector2(72, 323),
	Vector2(312, 323)
]

export var Page = 0
export var isEnabled = false

var selection : int = 0
var listSize : int = 0
var SoulSelection : int = 0

signal text(TextValue)
signal playerPosition(pos)
signal back(value)




func _physics_process(delta):

	itemMenu()


func itemMenu():
	if isEnabled:
		var MoveInput = Vector2(
			
			int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left")),
			int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
			)
		#the input calculations for the menus in undertale
		if MoveInput:
			listSize = len(Globals.items)
			selection = posmod(selection + MoveInput.x, listSize)
			selection = posmod(selection + MoveInput.y * 2, listSize)
			selection = selection % len(Globals.items)
			
			#page calculations
			
			SoulSelection = selection % 4
			Page = selection/4
			
			#repositions values after reaches certain maximum below threshold of 0
			if selection < 0: 
				selection = len(Globals.items) - 1
			
		#set text and positions
		emit_signal("playerPosition", SoulPos[SoulSelection])
			
		if Input.is_action_just_pressed("ui_cancel"):
			isEnabled = false
			selection = 0
			SoulSelection = 0
			Page = 0 
			emit_signal("back",2)


func GetItems():
	#this function array.slice is used to split the actual array stored in ItemDisplay between the 4 methods *i think*
	var array = Globals.items.slice(Page * 4, (Page * 4) + 3)
	var list : String
	var lines = 0
	
	
	#sets actual text itself
	for items in range(0, len(array)):
		list += "   * " + array[items]
		
		#this defines the space between the text
		for space in range(0, 12 - len(array[items])): 
			list += " "
		list += ""
		
		#sets new lines
		if (items + 1) % 2 == 0:
			list += "\n"
			lines += 1
			
	#sets line and then sets page number
	for _i in range(0, 2 - lines): list += "\n"
	list += "                    PAGE " + str(Page + 1)
	return list


