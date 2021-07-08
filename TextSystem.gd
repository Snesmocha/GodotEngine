extends CanvasLayer

onready var label = $RichTextLabel
onready var TextSystem = $"Menu Text For ActnStuff"

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

func _ready():
	print("Starting state: State.READY")
	hide_textbox()

	

func _process(_delta):

		
	match current_state:
		State.READY:
			if !text_queue.empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.FINISHED)

		State.FINISHED:
			TextSystem.INSTANT_PRINT = true


func queue_text(next_text):
	text_queue.push_back(next_text)

	
func hide_textbox():
	TextSystem.stop()

func display_text():
	var next_text = text_queue.pop_front()
	TextSystem.start("* " + next_text)
	change_state(State.READING)


func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")

func _on_Tween_tween_completed(object, key):
	change_state(State.FINISHED)


func _on_Battle_setText(text):
	queue_text(str(text))



func _on_Battle_clearText():
	TextSystem.stop()
