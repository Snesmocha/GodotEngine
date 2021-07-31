extends Node2D

#onready stuff
onready var Box = $NinePatchRect
onready var Colision = [$Kinematic/Left, $Kinematic/Right, $Kinematic/Top, $Kinematic/Bottom]
onready var tween = $Tween

#standard variables
var tweenMovementStyle = [Tween.TRANS_SINE, Tween.TRANS_QUINT, Tween.TRANS_QUART, Tween.TRANS_QUAD, Tween.TRANS_CUBIC, Tween.TRANS_CIRC]
var eases = [Tween.EASE_IN, Tween.EASE_IN_OUT, Tween.EASE_OUT, Tween.EASE_OUT_IN]
var standardPos = [-288, -70, 288, 70]

var velocity = Vector2.ZERO

#left, right, up down 
func moveBox(x1,x2,y1,y2, Movetype = Tween.TRANS_QUAD, Easetype = Tween.EASE_IN_OUT, speed = 2, delay = 0):
	tween.interpolate_property(Box, "margin_left", Box.margin_left, speed, x1, Movetype, Easetype,  speed, delay)
	tween.interpolate_property(Box, "margin_right", Box.margin_right, speed, x2, Movetype, Easetype,  speed, delay)
	tween.interpolate_property(Box, "margin_top", Box.margin_top, y1, speed, Movetype, Easetype,  speed, delay)
	tween.interpolate_property(Box, "margin_bottom", Box.margin_bottom, speed, y2, Movetype, Easetype, delay)	

	return [x1,x2,y1,y2]
	
#this is used to set back to og position
func StandardPos(Movetype = Tween.TRANS_QUAD, Easetype = Tween.EASE_IN_OUT, speed = 2):
	tween.interpolate_property(Box, "margin_left", Box.margin_left, -288, speed, Movetype, Easetype, speed)
	tween.interpolate_property(Box, "margin_right", Box.margin_right, 288, speed, Movetype, Easetype, speed)
	tween.interpolate_property(Box, "margin_top", Box.margin_top, -70, speed, Movetype, Easetype, speed)
	tween.interpolate_property(Box, "margin_bottom", Box.margin_bottom, 70, speed, Movetype, Easetype)	

	return 
	
	#this should only be used for rotation and that's it, don't be retarded 
func rotateBoxSet(x1 = 100,y1 = 100, Movetype = Tween.TRANS_QUAD, Easetype = Tween.EASE_OUT_IN, speed = 1):
#	StandardPos()
	tween.interpolate_property(Box, "margin_left", Box.margin_left, -x1,speed, Movetype, Easetype)
	tween.interpolate_property(Box, "margin_right", Box.margin_right, x1,speed, Movetype, Easetype)
	tween.interpolate_property(Box, "margin_top", Box.margin_top, -y1,speed, Movetype, Easetype)
	tween.interpolate_property(Box, "margin_bottom", Box.margin_bottom, y1,speed, Movetype, Easetype)	

	return 
	
#this is a tween movement, you can also just move the node
func moveFull(x1 = 320,y1 = 320, Movetype = 0, Easetype = 3, speed = 2):
	tween.interpolate_property(self, "position", position, Vector2(x1,y1), speed, tweenMovementStyle[Movetype], eases[Easetype])


#sets box col pos 
func boxcolision():
	Colision[0].position = Vector2(Box.margin_left - 45, (Box.margin_top + Box.margin_bottom) / 2)
#	Colision[0].scale = Vector2(0.25, Box.rect_size.y / 20.0)
	
	Colision[1].position = Vector2(Box.margin_right + 45, (Box.margin_top + Box.margin_bottom) / 2)
#	Colision[1].scale = Colision[0].scale
	
	Colision[2].position = Vector2((Box.margin_left + Box.margin_right) / 2, Box.margin_top - 45)
#	Colision[2].scale = Vector2(Box.rect_size.x / 20.0, 0.25)
	
	Colision[3].position = Vector2((Box.margin_left + Box.margin_right) / 2, Box.margin_bottom + 45)
#	Colision[3].scale = Colision[2].scale




##################################################################################################################################### Unified aka shared functions

func _physics_process(_delta: float) -> void:
	boxcolision()

	velocity = position
		
#	if active == true and combatTick == combatTick:
#		CombatZoneTick(delta)
	

var changeSize = false

func box_changeSize():
	return tween.start()



	
