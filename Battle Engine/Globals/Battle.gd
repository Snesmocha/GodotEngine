extends Node2D

var monster = EnemyStorage.sans 

onready var buttons = $Ui/Buttons
onready var menutext = $TextEngine/RichTextLabel




# Called when the node enters the scene tree for the first time.
func _ready():
	print(monster)
	get_tree().get_root().transparent_bg = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
