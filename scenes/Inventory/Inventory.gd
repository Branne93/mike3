extends Control
signal use_item(item)
#signal add_item(item)
signal disable_walk
signal enable_walk
var open = false


var node_dict= {}

func _ready():
	#global.connect("json_signal", self, "add_item")
	$CanvasLayer/TextureRect.connect("mouse_entered", self, "disable_walk")
	$CanvasLayer/TextureRect.connect("mouse_exited", self, "enable_walk")
	inventory_flags.connect("items_updated", self, "update_items")

#KNappar kan inte veta vilken knapp de hör till
func use_item_pripps():
	emit_signal("use_item", "pripps", inventory_flags.item_dict["pripps"])
func use_item_pripps2():
	emit_signal("use_item", "pripps", inventory_flags.item_dict["pripps"])
func use_item_pripps3():
	emit_signal("use_item", "pripps", inventory_flags.item_dict["pripps"])
func use_item_pripps4():
	emit_signal("use_item", "pripps", inventory_flags.item_dict["pripps"])
func use_item_pripps5():
	emit_signal("use_item", "pripps", inventory_flags.item_dict["pripps"])
	
func use_item_mynt():
	emit_signal("use_item", "mynt", inventory_flags.item_dict["mynt"])
	
func use_item_blaster():
	emit_signal("use_item", "blaster", inventory_flags.item_dict["blaster"])
	
func use_item_planka():
	emit_signal("use_item", "planka", inventory_flags.item_dict["planka"])
	
func add_item(item):
	if not item in inventory_flags.item_dict.keys():
		print("ERROR IN ADDING ITEM " + item)
		return
	var button = Button.new()
	button.set_button_icon(inventory_flags.item_dict[item])
	button.name = item
	button.set_flat(true)
	button.set_focus_mode(0)
	button.connect("button_down", self, "use_item_" + item)
	button.connect("mouse_entered", self, "disable_walk")
	button.connect("mouse_exited", self, "enable_walk")
	$CanvasLayer/TextureRect/HBoxContainer.add_child(button)
	node_dict[item] = button
	
func remove_item(item_name):
	var item = node_dict[item_name]
	$CanvasLayer/TextureRect/HBoxContainer.remove_child(item)

func update_items():
	clear()
	for item in inventory_flags.items:
		add_item(item)
	
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
		
