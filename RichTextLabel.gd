extends RichTextLabel



var itemList = Globals.itemList

# Called when the node enters the scene tree for the first time.
func _ready():
	itemUI()


func itemUI():
	for i in itemList:
		bbcode_text = " [fill]{text}[/fill] * " + str(itemList[0]) + "  * " + str(itemList[1]) + "  * " + str(itemList[3]) + "  * " + str(itemList[4])
