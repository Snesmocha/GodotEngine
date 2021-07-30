extends BackBufferCopy

onready var masking = $ColorRect
onready var Box = get_node_or_null("../BattleBox/NinePatchRect")

func setMasking(amount):
	masking.visible = true
	masking.margin_bottom = Box.margin_bottom - amount
	masking.margin_left = Box.margin_left + amount
	masking.margin_right = Box.margin_right - amount
	masking.margin_top = Box.margin_top + amount

func _physics_process(delta):
	setMasking(5)
