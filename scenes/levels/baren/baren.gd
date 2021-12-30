extends Node2D
export(String, FILE, "*.mid") var midi_music

func _ready():
	$pripps3/CollisionShape2D.disabled = true
	var offset_width = $Sprite.texture.get_width()
	$YSort/mike/Camera2D.limit_right = offset_width
	global.emit_signal("set_music", midi_music)
	global.emit_signal("start_music")
	$mynt.hide()
	$mynt/CollisionShape2D.disabled = true
	global.connect("add_mynt", self, "add_mynt")
	global.connect("add_pripps_bar", self, "add_pripps")
	if global.blaster_on_floor and not inventory_flags.items_collected.has("blaster"):
		$blaster/CollisionShape2D.disabled = false
		$blaster.show()
	else:
		$blaster/CollisionShape2D.disabled = true
	
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
		
func add_mynt():
	if not "mynt" in inventory_flags.items_collected:
		$mynt.show()
		$mynt/CollisionShape2D.disabled = false

func add_pripps():
	inventory_flags.items.erase("mynt")
	inventory_flags.emit_signal("items_updated")
	$pripps3.show()
	$pripps3/CollisionShape2D.disabled = false
	
