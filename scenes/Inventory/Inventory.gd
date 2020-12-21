extends Control
signal use_item(item)
#signal add_item(item)
signal disable_walk
signal enable_walk
var open = false

var item_dict = {"monsterhummus" : load("res://assets/monster_hummus.png"),
"gammal_ol" : load("res://assets/pripps.png"),
"rknapp" : load("res://assets/r-knappen.png"),
"mort" : load("res://assets/mort.png"),
"trassel" : load("res://assets/trassel.png")}
var node_dict= {}

func _ready():
	global.connect("json_signal", self, "add_item")
	$CanvasLayer/TextureRect.connect("mouse_entered", self, "disable_walk")
	$CanvasLayer/TextureRect.connect("mouse_exited", self, "enable_walk")

func use_item_monsterhummus():
	emit_signal("use_item", "monsterhummus", item_dict["monsterhummus"])
func use_item_gammal_ol():
	emit_signal("use_item", "gammal_ol", item_dict["gammal_ol"])
func use_item_rknapp():
	emit_signal("use_item", "rknapp", item_dict["rknapp"])
	
func use_item_mort():
	emit_signal("use_item", "mort", item_dict["mort"])
func use_item_trassel():
	emit_signal("use_item", "trassel", item_dict["trassel"])
	
func add_item(item):
	if item == "get_skor":
		show_skor()
		return
	#print("adding " + item)
	if not item in item_dict.keys():
		return
	var button = Button.new()
	button.set_button_icon(item_dict[item])
	button.name = item
	button.set_flat(true)
	button.set_focus_mode(0)
	button.connect("button_down", self, "use_item_" + item)
	button.connect("mouse_entered", self, "disable_walk")
	button.connect("mouse_exited", self, "enable_walk")
	$CanvasLayer/TextureRect/HBoxContainer.add_child(button)
	node_dict[item] = button
	global.connect("get_deo", self, "show_deo")
	global.connect("get_klader", self, "show_klader")
	
func remove_item(item_name):
	var item = node_dict[item_name]
	$CanvasLayer/TextureRect/HBoxContainer.remove_child(item)
	
func clear():
	for key in node_dict.keys():
		if node_dict[key]:
			remove_item(key)
	
func enable_walk():
	emit_signal("enable_walk")
func disable_walk():
	emit_signal("disable_walk")
	
func open_close():
	if open:
		open = false
		$CanvasLayer/TextureRect.hide()
		global.emit_signal("mike_set_animation", "stå")
	else:
		open = true
		$CanvasLayer/TextureRect.show()
		global.emit_signal("mike_set_animation", "tänk")
		
func show_deo():
	$CanvasLayer/deo.show()
func show_klader():
	$CanvasLayer/gymklader.show()
func show_skor():
	$CanvasLayer/gympaskor.show()
	global.skor = true
	
