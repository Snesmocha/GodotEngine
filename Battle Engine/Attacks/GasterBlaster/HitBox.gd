extends Area2D

# HitBox system.

var Damage = 0

func _physics_process(delta: float) -> void:
	var areas := get_overlapping_areas()
	for area in areas:
		if area.is_in_group("Player"):
			area.Hit(Damage)
