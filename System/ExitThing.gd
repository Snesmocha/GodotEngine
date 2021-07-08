extends CanvasLayer



func _process(_delta):
	$Label.modulate.a = Globals.exit
	
	if $Label.modulate.a == 1:
		get_tree().quit()
