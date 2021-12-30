extends Node2D

export(String, FILE, "*.tscn") var start_scene_path


func _ready():
	$scenechanger.set_scene(start_scene_path)
	global.connect("exit", $scenechanger, "set_scene")
	global.connect("set_music", $MidiPlayer, "set_file")
	global.connect("start_music", $MidiPlayer, "play")
	global.connect("stop_music", $MidiPlayer, "stop")

	
func fade_in():
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer, "animation_finished")
	return
	
func fade_out():
	$AnimationPlayer.play("fade_out")
	yield($AnimationPlayer, "animation_finished")
	return
