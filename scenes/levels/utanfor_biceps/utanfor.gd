extends Node2D
export(String, FILE, "*.mid") var midi_music

func _ready():
	$stromtrooper/Sprite.flip_h = true
	$stromtrooper/AnimationPlayer.play("stå")
	global.emit_signal("set_music", midi_music)
	global.emit_signal("start_music")

func _input(event):
	if event.is_action_pressed("map"):
		open_close_map()
		
func open_close_map():
	if $CanvasLayer/trattooinekarta.is_visible():
		$CanvasLayer/trattooinekarta.hide()
		$mike/mouse_control.active = true
	else:
		$CanvasLayer/trattooinekarta.show()
		$mike/mouse_control.active = false
