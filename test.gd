extends Node2D

class_name TurnQueue

onready var entities = $Entities

var active_character


func _ready():
	Globals.camera.setZoom(Vector2(0.1,0.1),0.5)
