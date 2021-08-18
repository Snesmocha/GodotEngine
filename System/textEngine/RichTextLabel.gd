extends CanvasLayer

onready var timer = $Node2D/RichTextLabel/Timer
onready var audio = $Node2D/RichTextLabel/AudioStreamPlayer
onready var richText = $Node2D/RichTextLabel
onready var pauseTimer = $PauseTimer
onready var speedTimer = $speedChangeTimer
onready var positioning = $Node2D

onready var text = []
onready var pause = [[10,0.5]]
onready var sound = [["killmekillme"]]
onready var speed = [[1,0.01],[5,0.01]]
onready var font = [[""]]
onready var skip = [false,0]
onready var interact = false
onready var currentPause = 0
onready var currentspeed = 0

var active = true

#the funi start on frame owo
func _ready():
	richText.bbcode_text = text[0]
	timer.start()
	pause.sort()
	if skip[0]:
		richText.visible_characters = len(richText.text)
	else:
		richText.visible_characters = 0
	
func _process(delta):
	
	if active:
		richText.bbcode_text = text[0]
		active = false
	

#text continuation and pausing system
func _on_Timer_timeout():
	if richText.visible_characters < len(richText.text):
		richText.visible_characters += 1
		if richText.text and richText.text[richText.visible_characters - 1] != "":
			if sound[0][0] != "":
				#reminder, add code that can change audio types depending on specific audio chosen 
				audio.play()
		
		#checks for pasueposition then pauses text accoring to how long the pause timer has been set
		if richText.visible_characters == pause[currentPause][0]:
			timer.stop()
			pauseTimer.start(pause[currentPause][1])
			
		if richText.visible_characters == speed[currentspeed][0]:
			print(timer.wait_time)
			timer.start(speed[currentspeed][1])
			if currentspeed < len(speed) - 1:
				currentspeed += 1


#pause system, i want to fucking dieeeeeeeeeeeeeeeeeeeeeeeeeeee
func _on_PauseTimer_timeout():
	if currentPause < len(pause) - 1:
		currentPause += 1
	
	pauseTimer.stop()
	timer.start()




