extends Node

func play(Sound : String, pitch = 1): # Function to play sounds without dying inside.
	get_node(Sound).play()
	get_node(Sound).pitch_scale = pitch
