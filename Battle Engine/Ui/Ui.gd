extends Node2D


onready var maxHealth = 16 + 4 * Globals.lv
onready var healthPoints = maxHealth

onready var health = $"Ui Elements/Health"
onready var hpBar = $"Meters/Hp"
onready var krBar = $Meters/Kr
onready var kr = $"Ui Elements/KR"
onready var lv = $"Ui Elements/Lv"

func _ready() -> void:
	health.bbcode_text = ""
	hpBar.max_value = maxHealth

func healthBar():
	health.bbcode_text = str(healthPoints).pad_zeros(len(str(maxHealth))) + " / " + str(maxHealth)
	if healthPoints > maxHealth:
		healthPoints = maxHealth
	hpBar.value = healthPoints
	
func _physics_process(delta: float) -> void:
	healthBar()
	levelSet()
	uiPlacement()

func levelSet():
	lv.bbcode_text = "LV " + str(Globals.lv)
	
func uiPlacement():
	

	
	if kr.visible == false:
		health.rect_position.x = krBar.margin_right * 3.65
	else:
		health.rect_position.x = krBar.margin_right * 3.78
#
#	krBar.margin_right = Globals.lv/healthPoints * 1000
#	hpBar.margin_right = Globals.lv/healthPoints * 500
	

func selection():
	pass
