extends Node2D

func _ready():
	#$AnimationPlayer.play("fade_out")
	$scenechanger.set_scene($scenechanger.main_menu)
	$scenechanger.scene_dict[$scenechanger.main_menu].connect("space_pressed", self, "start_game")
	
func start_game():
	#$AudioStreamPlayer.play()
	$scenechanger.set_scene($scenechanger.johanneberg)
	
func fade_in():
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer, "animation_finished")
	return
	
func fade_out():
	$AnimationPlayer.play("fade_out")
	yield($AnimationPlayer, "animation_finished")
	return
