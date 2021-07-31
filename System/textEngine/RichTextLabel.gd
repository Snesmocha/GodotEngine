extends RichTextLabel

onready var timer = $Timer
onready var audio = $AudioStreamPlayer

var enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func showDialogue(text:String, pause = [1], pauseTime = [0], changeSpeedPosition = [], changeSpeed = [], speed = 0.1):
	enabled = true
	
	if enabled:
		timer.start()
		bbcode_text = "* " + text
		timer.wait_time = speed
		percent_visible = 0
		timer.paused = false
		var current = 0
		var speedMoment = 0

		audio.stream_paused = false
		
		#will go through all the text within a certain period of time
		for i in len(text) + 2:
			self.visible_characters += 1
			
			#use the text, not the bbcode, don't be retarded like me
			if self.visible_characters < len(self.text):
				audio.play()
				
			if self.visible_characters == len(self.text):
				audio.stop()
				timer.stop()
				audio.stream_paused = true
			
			yield(timer, "timeout")
			
			#checks visible character count to see when to pause the script
			if visible_characters == pause[current] and len(pause) != 0:
				timer.paused = true
				
				yield(get_tree().create_timer(pauseTime[current]), "timeout")
				if current < len(pause) - 1:
					current += 1
				
				timer.paused = false
		
			if changeSpeed.size() != 0:
				if visible_characters == changeSpeedPosition[speedMoment] and len(changeSpeedPosition) != 0:
					timer.wait_time = changeSpeed[speedMoment]
					
					if speedMoment < len(changeSpeedPosition) - 1:
						speedMoment += 1
	else:
		timer.stop()


func instant(text:String):
	bbcode_text = "* " + text
	
func instaPrint():
	timer.stop()
	self.percent_visible = 1.0
	audio.stop()
	audio.stream_paused = true
	enabled = false

func clear():
	enabled = false
	bbcode_text = ""
	instaPrint()


func _on_item_text(TextValue):
	bbcode_text = TextValue
