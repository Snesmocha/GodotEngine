extends Node2D

# The least worst GasterBlaster script. Contains:
# - Movement.
# - Laser mechanic.

# Variables.
var bColor : int = 0

# GasterBlaster variables.
var End : Vector2 = Vector2.ZERO
var EndAng : float = 0
var Ang : float = 90
var State : int = 0
var GTimer : float = 0
var LeaveSpeed : float = 0

# Laser variables.
var BlastTime : float = 0
var BTimer : float = 0
var BaseSize : float = 0
var SineSize : float = 0

# It pisses me off that Godot uses a raw scaling system rather
# than a simple width/height system. This is a workaround for that
var FullScale1 : Vector2 = Vector2.ZERO
var FullScale2 : Vector2 = Vector2.ZERO
var FullScale3 : Vector2 = Vector2.ZERO
var FullScale4 : Vector2 = Vector2.ZERO

func _ready():
	# Disables the HitBox at start. For some reason I can't disable it
	# in the editor.
	$GasterBlastHit/HitBox/Collision.set_deferred("disabled", true)



func _process(delta):
	match bColor: # Colors go brr
		0:
			modulate = Color(1,1,1)
		1:
			modulate = Color8(0, 255, 255)
		2:
			modulate = Color8(255, 165, 0)
	
	Blaster(delta) # GasterBlaster function.
	Blast(delta) # Laser function.
	# Sets it's scale to the full scale (width/height).
	$GasterBlast.scale = Vector2(FullScale1.x / 16.0, FullScale1.y / 16.0)
	$GasterBlast2.scale = Vector2(FullScale2.x / 16.0, FullScale2.y / 16.0)
	$GasterBlast3.scale = Vector2(FullScale3.x / 16.0, FullScale3.y / 16.0)
	$GasterBlastHit.scale = Vector2(FullScale4.x / 16.0, FullScale4.y / 16.0)
	# Blaster looping to a certain frame.
	if $Blaster.animation == "fire": if $Blaster.frame == 5: $Blaster.frame = 3

func Blaster(delta):
	# Timer so you can control the time it takes for the GasterBlaster to shoot.
	if GTimer > 0: if State == 1 or State == 2: GTimer -= min(delta, GTimer)
	match State:
		0: # Movement system. Don't change it to Vector2 it will look weird.
			# I also had to change it from 3.0 to 2.05 to reduce the chunky
			# snapping.
			if abs($Blaster.position.x - End.x) >= 2.05:
				$Blaster.position.x +=(End.x - $Blaster.position.x) * delta * 10
			if abs($Blaster.position.x - End.x) < 2.05:
				$Blaster.position.x = End.x
		
			if abs($Blaster.position.y - End.y) >= 2.05:
				$Blaster.position.y += (End.y - $Blaster.position.y) * delta * 10
			if abs($Blaster.position.y - End.y) < 2.05:
				$Blaster.position.y = End.y
		
			if abs(Ang - EndAng) >= 2.05:
				Ang += (EndAng - Ang) * delta * 10
				$Blaster.rotation_degrees = Ang
			if abs(Ang - EndAng) < 2.05:
				Ang = EndAng
				$Blaster.rotation_degrees = Ang
			# Sets the state to 1 once it settled
			if $Blaster.position == End and Ang == EndAng: State = 1
		1:
			if GTimer <= 0: # If the timer reaches 0 (had to do <= because it printed out -0)
				$Blaster.animation = "fire"
				$Blaster.play()
				State = 2
				GTimer = 0.1 # Delay before the actual shooting
		2:
			if GTimer <= 0:
				State = 3
				# Shakes the screen depending on the scale.
				Globals.camera.shake($Blaster.scale.x * 3.0)
				# Enables the HitBox.
				$GasterBlastHit/HitBox/Collision.set_deferred("disabled", false)
#				Globals.Sample.play("GasterBlast", 1.2)
#				Globals.Sample.play("GasterBlast2", 1.2)
				$GasterBlast.show()
				$GasterBlast2.show()
				$GasterBlast3.show()
		3:
			# Leaving code.
			if $Blaster/VisibilityNotifier2D.is_on_screen(): LeaveSpeed += 30.0
			else: LeaveSpeed = 0
			$Blaster.position.x -= cos($Blaster.rotation) * delta * LeaveSpeed
			$Blaster.position.y -= sin($Blaster.rotation) * delta * LeaveSpeed

func Blast(delta):
	if $GasterBlast.visible == true: 
		BTimer += delta
		# Lerps to 35 * the y scale of the GasterBlaster for 2 frames at 60 fps.
		if BTimer < 4.0 / 30.0: BaseSize += floor(35.0 * $Blaster.scale.y / 4.0) * delta * 30.0
		if BTimer >= 4.0 / 30.0 and BTimer < 4.0 / 30.0 + delta: BaseSize = 35.0 * $Blaster.scale.y
		if BTimer > 5.0 / 30.0 + BlastTime:
			# Shrinking code.
			BaseSize = BaseSize * pow(0.8, delta * 30.0)
			$GasterBlast.modulate.a = (100.0 - ((BTimer - BlastTime) * 30.0 - 5.0) * 10.0) / 100.0
			if BaseSize <= 2: queue_free() # if the BaseSize is 2 or under it frees the whole blaster
		# Disables the laser HitBox once again.
		if $GasterBlast.modulate.a <= 0.8: $GasterBlastHit/HitBox/Collision.set_deferred("disabled", true)
		
		# Wobble and set scaling code.
		SineSize = sin(deg2rad(BTimer * 30.0 / 1.5 * 180.0 / PI)) * BaseSize / 4.0
		FullScale1.y = BaseSize + SineSize
		FullScale2.y = BaseSize / 1.25 + SineSize
		FullScale3.y = BaseSize / 2.0 + SineSize
		FullScale4.y = BaseSize * 3.0 / 4.0
	
	# Positioning of the Lasers relative to the GasterBlaster.
	var Scale = $Blaster.scale.y / 2.0
	
	$GasterBlast.position = Vector2($Blaster.position.x + cos($Blaster.rotation) * 70.0 * Scale, $Blaster.position.y + sin($Blaster.rotation) * 70.0 * Scale)
	$GasterBlast.rotation = $Blaster.rotation
	FullScale1.x = 1000.0
	
	$GasterBlast2.position = Vector2($Blaster.position.x + cos($Blaster.rotation) * 60.0 * Scale, $Blaster.position.y + sin($Blaster.rotation) * 60.0 * Scale)
	$GasterBlast2.rotation = $Blaster.rotation
	FullScale2.x = 10.0 * Scale
	$GasterBlast2.modulate.a = $GasterBlast.modulate.a
	
	$GasterBlast3.position = Vector2($Blaster.position.x + cos($Blaster.rotation) * 50.0 * Scale, $Blaster.position.y + sin($Blaster.rotation) * 50.0 * Scale)
	$GasterBlast3.rotation = $Blaster.rotation
	FullScale3.x = 20.0 * Scale
	$GasterBlast3.modulate.a = $GasterBlast.modulate.a
	
	$GasterBlastHit.position = Vector2($Blaster.position.x + cos($Blaster.rotation) * 70.0 * Scale, $Blaster.position.y + sin($Blaster.rotation) * 70.0 * Scale)
	$GasterBlastHit.rotation = $Blaster.rotation
	FullScale4.x = 1000.0
