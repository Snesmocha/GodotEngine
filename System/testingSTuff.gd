extends Node2D

onready var icon = preload("res://System/tests/that thing that avranik makes.tscn")


func createObjects():
	var object = icon.instance()
	self.add_child(object)
	return object
	

onready var storage = []

func _ready():
	for i in 5:
		storage.append(createObjects())

	storage[1].timerMultiplier = 8 /2
	storage[2].timerMultiplier = 6 /2
	storage[3].timerMultiplier = 4 /2
	storage[4].timerMultiplier = 2 /2
	storage[0].timerMultiplier = 10 / 2 
	
	for i in 50:
		print(storage)
		yield(get_tree().create_timer(1),"timeout")
