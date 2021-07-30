extends KinematicBody2D

onready var Heart = $PlayerHeart

export var max_speed = 75
export var accel = 200 
export var friction = 200

var input_vector = Vector2.ZERO

#value to store constents


#vector 2 posisions and then zero just means blank variable
var velocity = Vector2.ZERO
var MoveInput : Vector2 = Vector2.ZERO
export var state = 0



#basicly physics properties
#velocity code
func _physics_process(delta):

	debug()
	match state:
		0:
			
			Heart.self_modulate = Color(1,0,0)
			Heart.rotation_degrees = 90
		
		1:
			redsoul(delta)
		2:
			bluesoul(delta)
		3:
			orangesoul(delta)
		


func redsoul(delta):	
	
	Heart.self_modulate = Color(1,0,0)
	Heart.rotation_degrees = 90
	
	input_vector = Vector2( Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
	Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, accel * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	if Input.is_action_pressed("ui_cancel"):
		max_speed = 50
	if Input.is_action_just_released("ui_cancel"):
		max_speed = 100	
	
	move_and_slide(velocity)
	velocity = move_and_slide(velocity)


#variables dedicated to the blue soul cause i don't know how this works
export(int,0,3) var GravityType : int = 0
export(int,-360,360) var GravDir = 1


enum BlueDirection {
	LEFT = 0
	UP = 1
	RIGHT = 2
	DOWN = 3
}

#shit ton of variables
export var Gravity = 250
var Snap = false
var SlideThreshold : float = 50.0
var HeartSpeed = 150
export var Jump = Vector2(30, 180)
export var slam = true
var maxFallSpeed = 5000
const setGravity = 250


#original code from scarm, modifications from me
func bluesoul(delta):
	Heart.self_modulate = Color(0,0.25,1)
	Heart.rotation_degrees = GravDir
	
	var GravDirection = Vector2(cos(Heart.rotation), sin(Heart.rotation))
	var Floor : Vector2
	var VectorDirection = {
		BlueDirection.UP: Vector2.UP,
		BlueDirection.DOWN: Vector2.DOWN,
		BlueDirection.LEFT: Vector2.LEFT,
		BlueDirection.RIGHT: Vector2.RIGHT
		}
	
	#the input collection, this big ass list is used to store inputs to be used in manipulation of gravity
	var InputList = [
	int(Input.get_action_strength("ui_left")),
	int(Input.get_action_strength("ui_up")),
	int(Input.get_action_strength("ui_right")),
	int(Input.get_action_strength("ui_down"))
	]
	
	#the input list
	MoveInput = Vector2(InputList[2] - InputList[0], InputList[3] - InputList[1])
	#checks floor type
	Floor = VectorDirection[GravityType]
	
	if GravityType > 4:
		GravityType = 0
	elif GravityType < 0:
		GravityType = 4
	
	#left and right movement for upside down and right side up
	if GravityType == BlueDirection.UP or GravityType == BlueDirection.DOWN:
		velocity.x = MoveInput.x * HeartSpeed
		#checks velocity type
		
		if InputList[GravityType] and Snap:
			#opposites shit
			velocity.y = Jump.y * Floor.y
			Snap = false
			
		else:
			if (
				GravityType == BlueDirection.UP and not InputList[GravityType] and not Snap and velocity.y < -Jump.x or
				GravityType == BlueDirection.DOWN and not InputList[GravityType] and not Snap and velocity.y > Jump.x
				):
					#the fucking jump and gravity
					velocity.y = Jump.x * Floor.y
		
	if GravityType == BlueDirection.LEFT or GravityType == BlueDirection.RIGHT:
		velocity.y = MoveInput.y * HeartSpeed
		
		if InputList[GravityType] and Snap:
			velocity.x = Jump.y * Floor.x
			Snap = false
			
		else:
			if (
				GravityType == BlueDirection.LEFT and not InputList[GravityType] and not Snap and velocity.x < -Jump.x or
				GravityType == BlueDirection.RIGHT and not InputList[GravityType] and not Snap and velocity.x > Jump.x 
				):
					velocity.x = Jump.x * Floor.x
	
	#how gravity is calculated
	velocity += Vector2(GravDirection.x * Gravity * delta, GravDirection.y * Gravity * delta)
	#allows use of platforms
	var snapVector = Floor * 32 if Snap else Vector2()
	velocity = move_and_slide_with_snap(velocity, snapVector, Floor, SlideThreshold)
	




	#slam system
	if slam == true:
		Gravity = maxFallSpeed
	if is_on_floor() and slam == true:
		slam = false
		Gravity = setGravity
		Globals.camera.shake(300,0.24,1000)
	
		
	var JustLanded = is_on_floor() and not Snap
	if JustLanded:
		Snap = true


func orangesoul(delta):
	Heart.self_modulate = Color(1,0.5,0)
	Heart.rotation_degrees = 90
	
	max_speed = 150
	
	input_vector = Vector2( Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
	Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, accel * delta)
		

	move_and_slide(velocity)
	velocity = move_and_slide(velocity)
		
#no you idiot, don't use this
func debug():
	if Input.is_key_pressed(KEY_W):
		GravityType = 3
		GravDir = 270
		slam = true
	if Input.is_key_pressed(KEY_A):
		GravityType = 2
		GravDir = 180
		slam = true
	if Input.is_key_pressed(KEY_S):
		GravDir = 90
		GravityType = 1
		slam = true
	if Input.is_key_pressed(KEY_D):
		GravityType = 0
		GravDir = 0
		slam = true
	if Input.is_action_just_pressed("ui_focus_prev"):
		state -= 1
	if Input.is_action_just_pressed("ui_focus_next"):
		state += 1
