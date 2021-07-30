extends Node2D



onready var health = $"Ui Elements/Health"
onready var hpBar = $"Meters/Hp"
onready var krBar = $Meters/Kr
onready var kr = $"Ui Elements/KR"
onready var lv = $"Ui Elements/Lv"


func _ready() -> void:
	health.bbcode_text = ""
	hpBar.max_value = Globals.maxHealth

func healthBar():
	health.bbcode_text = str(Globals.health).pad_zeros(len(str(Globals.maxHealth))) + " / " + str(Globals.health)
	if Globals.health > Globals.maxHealth:
		Globals.health = Globals.maxHealth
	hpBar.value = Globals.health
	
func _physics_process(_delta: float) -> void:
	healthBar()
	levelSet()
	uiPlacement()

func levelSet():
	lv.bbcode_text = "LV " + str(Globals.lv)
	
func uiPlacement():
	kr.position.x = krBar.margin_right + 290
	if kr.visible == false:
		health.rect_position.x = krBar.margin_right + 290
		krBar.margin_right = int(20 + (Globals.maxHealth * 1.1))
		hpBar.margin_right = int(20 + (Globals.maxHealth * 1.1))
		
	else:
		health.rect_position.x = krBar.margin_right + 320
		krBar.margin_right = int(20 + (Globals.maxHealth * 0.85))
		hpBar.margin_right = int(20 + (Globals.maxHealth * 0.85))
