extends Node

var devmode = false

var camera = null
var lv = 19

var itemList = ["heal 1","heal 2","heal 3","heal 4","heal 5",]

var fullscreen = 0
var exit = 0

var label = null
	

func _physics_process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		fullscreen += 1
	if Input.is_action_pressed("exit"):
		if devmode == false:
			exit += 0.01
		elif devmode == true:
			exit = 1
	
	elif Input.is_action_just_released("exit"):
		exit = 0 
	
	match fullscreen:
		0:
			OS.window_fullscreen = false
		1:
			OS.window_fullscreen = true
		2:
			fullscreen = 0
