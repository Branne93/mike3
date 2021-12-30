extends Node2D
export(String, FILE, "*.mid") var midi_music

func _ready():
	global.emit_signal("set_music", midi_music)
	global.emit_signal("start_music")
	if global.planka_set:
		set_planka()
	else:
		$pripps5/CollisionShape2D.disabled = true
	if inventory_flags.items_collected.has("pripps5"):
		$pripps5.hide()
		$pripps5/CollisionShape2D.disabled = true

func set_planka():
	$mike.pathfinder = $Navigation2D2
	inventory_flags.items.erase("planka")
	inventory_flags.emit_signal("items_updated")
	$planka.show()

func used_with_item(item):
	if item == "planka":
		global.planka_set = true
		set_planka()
		$pripps5/CollisionShape2D.disabled = false
		global.emit_signal("planka_set")
		return true
	return false
	
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
