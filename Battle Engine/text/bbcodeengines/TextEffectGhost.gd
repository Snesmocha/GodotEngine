#ignore this shit up here
tool
extends RichTextEffect
class_name RichTextGhost

#ignore this as well
# Syntax: [ghost freq=5.0 span=10.0][/ghost]

# Define the tag name.
var bbcode = "ghost"

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var speed = char_fx.env.get("freq", 5.0)
	var span = char_fx.env.get("span", 10.0)

	#changes the alpha of each character
	var alpha = sin(char_fx.elapsed_time * speed + (char_fx.absolute_index / span)) * 0.5 + 0.5
	#now changes each character individually
	char_fx.color.a = alpha
	return true
