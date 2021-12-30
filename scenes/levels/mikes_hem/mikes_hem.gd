extends Node2D

func _ready():
	global.emit_signal("stop_music")
	var offset_width = $Sprite.texture.get_width()
	$YSort/mike/Camera2D.limit_right = offset_width
	$pripps2/CollisionShape2D.disabled = true
	global.connect("pripps_skjuten", self, "skjut_pripps")
	if global.mikes_hem_first and not global.debug:
		$YSort/mike/CanvasLayer/actions.hide()
		global.mikes_hem_first = false
		$YSort/mike/mouse_control.active = false
		$Timer.start()
		yield($Timer, "timeout")
		$dialogue_player.start_dialogue()
		$YSort/mike/Sprite.flip_h = true
		yield($dialogue_player, "dialogue_finished")
		$YSort/mike/CanvasLayer/actions.show()
		
	if inventory_flags.items_collected.has("pripps"):
		$pripps.queue_free()
	if inventory_flags.items_collected.has("pripps2"):
		$flygpripps.queue_free()
	if global.mknapp_active:
		$scenechange_titta.hide()
	
func _input(event):
	if global.mknapp_active and event.is_action_pressed("map"):
		open_close_map()
		
func open_close_map():
	if $CanvasLayer/trattooinekarta.is_visible():
		$CanvasLayer/trattooinekarta.hide()
		$YSort/mike/mouse_control.active = true
	else:
		$CanvasLayer/trattooinekarta.show()
		$YSort/mike/mouse_control.active = false
		
func skjut_pripps():
	$flygpripps.hide()
	$pripps2/CollisionShape2D.disabled = false
	$pripps2.show()
	
