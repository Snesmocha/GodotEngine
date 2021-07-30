extends Sprite

var tempTimer = 0
export var amount = 5
export var scaler = 0.05
export var timerMultiplier = 2
export var posMultiplier = 4

func _physics_process(delta):
	position.x += cos(tempTimer * timerMultiplier) * posMultiplier
	position.y += sin(tempTimer * timerMultiplier) * posMultiplier / 2
	scale.x += sin(tempTimer * 2) * scaler
	scale.y += sin(tempTimer * 2) *  scaler
	
	tempTimer += delta
