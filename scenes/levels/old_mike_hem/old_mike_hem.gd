extends Node2D
export(String, FILE, "*.mid") var midi_music

func _ready():
	global.emit_signal("set_music", midi_music)
	global.emit_signal("start_music")
	$mike/Sprite.flip_h = true
	if inventory_flags.items_collected.has("planka"):
		$planka.hide()
		$planka/CollisionShape2D.disabled = true
	if not global.old_mike_active:
		$Mike_Old/dialogue_player.start_dialogue()
		$Mike_Old.activate()

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
