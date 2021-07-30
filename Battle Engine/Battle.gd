extends Node2D

var monster 

onready var buttons = $Ui/Buttons
onready var menutext = $TextEngine/RichTextLabel

var Name = Globals.name
var attackType = "sans"
var lv = Globals.lv


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
