extends Node

var devmode = false


#functions
var camera = null

#debug/gameinternal shit
var framerate = 60
var fullscreen = 0
var exit = 0

var items = ["item!","killme","faggot","dumbass","reni cute","kyo femboi", "no seeri", "pubigub pog", "core pog", "underboi p", "russia", "sidoka"]

#player stats
var lv = 1
onready var health = maxHealth
var maxHealth = 16 + 4 * lv
var charName = "frisk"

#master Items List
var label = null
	


func _process(_delta):
	Engine.set_target_fps(framerate)
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
