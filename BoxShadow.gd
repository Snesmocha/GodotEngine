extends Node2D


onready var rectShadow = $NinePatchRect

func _on_Timer_timeout() -> void:
	queue_free()

