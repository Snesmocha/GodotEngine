extends CanvasLayer

export var Active = true
export var Destroy = false

#instation menus
onready var Debug = $Debug

#calling values ahead
onready var battle = get_node("..")
onready var soul = get_node("../Player")

func _process(delta):
	
	for i in get_children():
		i.visible = Active
	
	

func _ready():
	Debug.bbcode_text = "null"
	
	if Destroy == true:
		for i in get_children():
			i.queue_free()
