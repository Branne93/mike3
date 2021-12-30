extends Node2D
var input_enabled = false
export(String, FILE, "*.tscn") var next_scene
#var next_scene = "res://scenes/cutscenes/korridor_fly/korridor_fly_cutscene.tscn"

func _ready():
	$"tryck för starta".hide()
	$AnimationPlayer.play("loggofade")
	$AnimationPlayer.queue("fade_in_presenterar1")
	#$AnimationPlayer.queue("fade in presenterar2")
	$AnimationPlayer.queue("Ny Anim")
	$AnimationPlayer.connect("animation_finished", self, "start_intro")

func start_intro(_animation):
	$AnimationPlayer.disconnect("animation_finished", self, "start_intro")
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("star_wars_loggo_in")
	$AnimationPlayer.queue("scrolla_text")
	$AnimationPlayer.queue("scrolla_ner_kamera")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer2.play("skepp_skakar")
	$Timer.start()
	$AnimationPlayer.queue("mute_musik")
	yield($Timer, "timeout")
	global.emit_signal("exit", next_scene)
