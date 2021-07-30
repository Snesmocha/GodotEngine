extends Node2D


onready var attack = preload("res://Battle Engine/Attacks/GasterBlaster/GasterBlaster.tscn")

onready var box = get_node_or_null("../BattleBox")

func GasterBlaster(Size, Position : Vector2, End : Vector2, EndAng, GTimer, BlastTime, bColor : int = 0):
	var instance = attack.instance()
	var gb = instance.get_node("Blaster")
	instance.position = Vector2.ONE * -320
	gb.rotation_degrees = instance.Ang
	var _Size = Size
	gb.position = Position
	instance.End = End
	instance.EndAng = EndAng
	instance.GTimer = GTimer
	instance.BlastTime = BlastTime
	instance.bColor = bColor
	if gb.position == instance.End:
		instance.Ang = instance.EndAng
		gb.rotation_degrees = instance.Ang
	if Size == 0 or Size == 1: gb.scale = Vector2(2,1)
	else: gb.scale = Vector2.ONE * Size
	add_child(instance)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	pass
