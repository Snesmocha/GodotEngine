extends Node2D


onready var bone = preload("res://Battle Engine/Attacks/Bones/Horizontal/Bone.tscn")
onready var tween = $Tween

func instancing(positioning):
	var system = bone.instance()
	system.rect_position.y = 320
	system.rect_position.x = positioning
	tween.interpolate_property(system, "margin_right", system.margin_right + 1200, 20, 10, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	$Node2D.add_child(system)
	

func _ready():
	for i in 100000:
		instancing(i)
		yield(get_tree().create_timer(0.01),"timeout")

func _physics_process(delta):
	$CanvasLayer/RichTextLabel.text = str($Node2D.get_child_count())
	if Input.is_action_pressed("ui_left"):
		$Camera2D.position.x += 2
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
