extends Node2D


onready var tween = $Tween
onready var team = $team
onready var desktop = $desktop
onready var backplate = $"that expand fade thing"
onready var animationPlayer = $AnimationPlayer
onready var camera = $Camera2D

export var devMode: bool = false

var audio = [
load("res://audio/intro/mus_sfx_star.wav"), 
load("res://slash.wav"), 
load("res://audio/intro/zoom.wav"), 
load("res://audio/intro/hit.wav"), 
load("res://audio/intro/snd_fall.wav"),
load("res://audio/intro/comeinFromSide.wav"),
load("res://audio/intro/mus_singG.wav")
]

func _ready() -> void:
	if OS.is_debug_build():
		devMode = true
	
	backplate.visible = false
	team.position.x = -100
	desktop.position.y = -50
	yield(get_tree().create_timer(2), "timeout")
	introPart()
	switchScenes()
	audio()
	tween.interpolate_property(desktop,"position", Vector2(desktop.position.x, -50),Vector2(desktop.position.x, 283), 3, Tween.TRANS_BOUNCE, Tween.EASE_OUT) 
	tween.interpolate_property(team,"position", Vector2(-50, team.position.y),Vector2(315, team.position.y), 3, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 2) 
	tween.interpolate_property(camera, "zoom", camera.zoom, Vector2(0.01,0.01), 2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 6)
	tween.interpolate_property(camera, "rotation_degrees", camera.rotation_degrees, 40, 3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 6)
	animationPlayer.play("fade")
	tween.start()
	if devMode == true:
		$AnimationPlayer2.play("devModeFade")

func introPart():
	yield(get_tree().create_timer(4.2), "timeout")
	backplate.visible = true
	$CanvasLayer/ColorRect.visible = true

func audio():
	AudioManager.play_sfx(audio[4])
	yield(get_tree().create_timer(1), "timeout")
	AudioManager.play_sfx(audio[3])
	yield(get_tree().create_timer(1), "timeout")
	AudioManager.play_sfx(audio[5])
	yield(get_tree().create_timer(2.1), "timeout")
	AudioManager.play_sfx(audio[6])
	yield(get_tree().create_timer(1.9), "timeout")
	AudioManager.play_sfx(audio[2])

func switchScenes():
	yield(get_tree().create_timer(8.5), "timeout")
	queue_free()
	get_tree().change_scene("res://overworld.tscn")
