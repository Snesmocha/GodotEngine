extends Position2D


const BONE = preload("res://Battle Engine/Attacks/Bones/Horizontal/Bone.tscn")

var frameTimer = 0
var bulletAmount = 5
var spawnTime = 100
var timer = 0
var bulletAmountMultiplyer = spawnTime / bulletAmount


func createBone():
	var boneCreate = BONE.instance()
	self.add_child(boneCreate)

	return boneCreate
	
onready var attacktest = []


var posx = 0
var posy = 0
		
		
func _ready():
	print(bulletAmountMultiplyer)

func _physics_process(delta):
	frameTimer += 1
	if frameTimer < spawnTime:
		posx = cos(frameTimer / (bulletAmount * bulletAmountMultiplyer) * PI)
		posy = sin(frameTimer / (bulletAmount * bulletAmountMultiplyer) * PI)

		for i in bulletAmount:
			attacktest.append(createBone())
			attacktest[i].rect_position = Vector2(posx,posy)

			
		print(attacktest)

	timer += delta

