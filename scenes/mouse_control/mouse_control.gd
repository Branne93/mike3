extends Node
signal go_to(point)
export(NodePath) var mike_path
export(NodePath) var actions_path
export(NodePath) var inventory_path
var mike
var actions
var inventory


var cursors = {"prata" : load("res://assets/prata_ikon.png"), 
			"titta" : load("res://assets/titta.png"),
			"plocka": load("res://assets/plocka.png"),
			"putta": load("res://assets/putta.png")}

var walk = true
var current_action = "walk"
var active = true

var j3ns_pekare = load("res://assets/j3n5_pekare.png")
var d4v3_pekare = load("res://assets/d4v3_pekare.png")
var mike_old_pekare = load("res://assets/mike_old_pekare.png")

func _ready():
	mike = get_node(mike_path)
	actions = get_node(actions_path)
	inventory = get_node(inventory_path)
	actions.connect("action", self, "action")
	actions.connect("enable_walk", self, "enable_walk")
	actions.connect("disable_walk", self, "disable_walk")
	inventory.connect("use_item", self, "item_used")
	inventory.connect("enable_walk", self, "enable_walk")
	inventory.connect("disable_walk", self, "disable_walk")
	

func _input(event):
	if not active:
		return
	var left_click_pressed = event is InputEventMouseButton and event.is_action_pressed("left_click")
	var left_click_release = event is InputEventMouseButton and event.is_action_released("left_click")
	if left_click_pressed:
		$cursor.position = $cursor.get_global_mouse_position() 
		$cursorplocka.position = $cursorplocka.get_global_mouse_position()
		$cursorprata.position = $cursorprata.get_global_mouse_position()
		$cursoruse.position = $cursoruse.get_global_mouse_position()
	elif current_action == "walk" and left_click_release:
		emit_signal("go_to", $cursor.position)
	elif current_action == "prata" and left_click_release:
		talk($cursorprata.get_collider())
		reset_cursor()
	elif current_action == "titta" and left_click_release:
		titta($cursor.get_collider())
		reset_cursor()
	elif current_action == "plocka" and left_click_release:
		plocka($cursorplocka.get_collider())
		if not current_action in ["j3n5", "d4v3", "mike_old"]:
			reset_cursor()
	elif current_action == "putta" and left_click_release:
		putta($cursor.get_collider())
		reset_cursor()
	elif left_click_release:
		use_item_with($cursoruse.get_collider())
		reset_cursor()

func action(action):
	current_action = action
	Input.set_custom_mouse_cursor(cursors[action])
	
func use_item_with(node):
	if not node:
		mike.talk_to_self("Nä det funkar inte.")
		return
	if node.has_method("used_with_item"):
		if(node.used_with_item(current_action)):
			return
	if node.get_owner().has_method("used_with_item"): #Special case
		if(node.get_owner().used_with_item(current_action)):
			return
	mike.talk_to_self("Nä det funkar inte.")
	
func item_used(item_name, item_image):
	current_action = item_name
	Input.set_custom_mouse_cursor(item_image)
	
func get_deo():
	global.emit_signal("get_deo")
	global.deo = true
	inventory.remove_item("monsterhummus")
	inventory.remove_item("gammal_ol")
	reset_cursor()
	
func talk(node):
	if not node:
		return
	if node.has_node("dialogue_player"):
		node.get_node("dialogue_player").start_dialogue()
		return
#	node = node.get_parent()
#	if not node.has_node("dialogue_player"):
#		return
#	node.get_node("dialogue_player").start_dialogue()
	
func plocka(node):
	if not node:
		return
	if node.name == "j3ns":
		item_used("j3n5", j3ns_pekare)
	elif node.name == "d4v3":
		item_used("d4v3", d4v3_pekare)
	elif node.name == "Mike_Old":
		item_used("mike_old", mike_old_pekare)
	else:
		inventory_flags.items.append(node.name)
		inventory_flags.items_collected.append(node.name)
		node.queue_free()
		inventory_flags.emit_signal("items_updated")
	
func putta(node):
	if not node:
		return
	if node.has_method("putta"):
		node.putta(mike)
		return
	node = node.get_parent()
	if not node.has_method("putta"):
		return
	node.putta(mike)
	
func titta(node):
	if not node:
		return
	if node.has_method("titta"):
		node.titta(mike)
		return
	node = node.get_parent()
	if not node.has_method("titta"):
		return
	node.titta(mike)
	
	
func enable_walk():
	active = true
func disable_walk():
	active = false
	
func reset_cursor():
	current_action = "walk"
	Input.set_custom_mouse_cursor(null)
