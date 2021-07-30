extends RichTextLabel

onready var timer = $Timer
onready var audio = $AudioStreamPlayer


var attack = true

# Called when the node enters the scene tree for the first time.
func _ready():
	showDialogue("[wave]let the battle[/wave] [shake rate=20 level=7][color=red]begin", [17], [1])

func showDialogue(text:String, pause = [1], pauseTime = [0], changeSpeedPosition = [], changeSpeed = [], speed = 0.01):
	bbcode_text = "* " + text
	timer.wait_time = speed
	percent_visible = 0
	var current = 0
	var speedMoment = 0
	timer.start()
	
	#will go through all the text within a certain period of time
	for i in len(text) + 2:
		self.visible_characters += 1
		print(len(self.text))
		
		if self.visible_characters < len(self.text):
			audio.play()
		
		if self.visible_characters == len(self.text):
			audio.stop()
		
		yield(timer, "timeout")
		
		#checks visible character count to see when to pause the script
		if visible_characters == pause[current] and len(pause) != 0:
			timer.paused = true
			print(current)
			
			yield(get_tree().create_timer(pauseTime[current]), "timeout")
			if current < len(pause) - 1:
				current += 1
			
			timer.paused = false
	
		if changeSpeed.size() != 0:
			if visible_characters == changeSpeedPosition[speedMoment] and len(changeSpeedPosition) != 0:
				timer.wait_time = changeSpeed[speedMoment]
				if speedMoment < len(changeSpeedPosition) - 1:
					speedMoment += 1


func instant(text:String):
	bbcode_text = "* " + text

func clear():
	bbcode_text = ""
