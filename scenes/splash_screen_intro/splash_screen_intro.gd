extends Node2D
var input_enabled = false
signal space_pressed

func _ready():
	$"tryck för starta".hide()
	$AnimationPlayer.play("loggofade")
	$AnimationPlayer.queue("fade_in_presenterar1")
	#$AnimationPlayer.queue("fade in presenterar2")
	$AnimationPlayer.queue("Ny Anim")
	$AnimationPlayer.connect("animation_finished", self, "start_intro")
	
func _input(event):
	if input_enabled and event.is_action_pressed("spacebar"):
		input_enabled = false
		$AnimationPlayer.play("mute_musik")
		$Timer.start()
		yield($Timer, "timeout")
		emit_signal("space_pressed")
		

func start_intro(animation):
	$AnimationPlayer.disconnect("animation_finished", self, "start_intro")
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("star_wars_loggo_in")
	$AnimationPlayer.queue("scrolla_text")
	$AnimationPlayer.queue("mute_musik")
	$AnimationPlayer.queue("scrolla_ner_kamera")
	input_enabled = true
