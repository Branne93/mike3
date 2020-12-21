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
	elif current_action == "walk" and left_click_release:
		emit_signal("go_to", $cursor.position)
	elif current_action == "prata" and left_click_release:
		talk($cursor.get_collider())
		reset_cursor()
	elif current_action == "titta" and left_click_release:
		titta($cursor.get_collider())
		reset_cursor()
	elif current_action == "plocka" and left_click_release:
		plocka($cursor.get_collider())
		reset_cursor()
	elif current_action == "putta" and left_click_release:
		putta($cursor.get_collider())
		reset_cursor()
	elif left_click_release:
		use_item_with($cursor.get_collider())
		reset_cursor()

func action(action):
	current_action = action
	Input.set_custom_mouse_cursor(cursors[action])
	
func use_item_with(node):
	if not node:
		mike.talk_to_self("Nä det funkar inte.")
		return
	if node.has_method("used_with_item"):
		if node.used_with_item(current_action):
			inventory.open_close()
			inventory.remove_item(current_action)
			return
	node = node.get_parent()
	if node.has_method("used_with_item"):
		if node.used_with_item(current_action):
			inventory.open_close()
			inventory.remove_item(current_action)
			return
	mike.talk_to_self("Nä det funkar inte.")
	
func item_used(item_name, item_image):
	print(current_action, item_name)
	if (current_action == "monsterhummus" and item_name == "gammal_ol") or (current_action == "gammal_ol" and item_name == "monsterhummus"):
		get_deo()
		return
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
	print("pratar med " + node.name)
	if node.has_node("dialogue_player"):
		node.get_node("dialogue_player").start_dialogue()
		return
	node = node.get_parent()
	if not node.has_node("dialogue_player"):
		return
	node.get_node("dialogue_player").start_dialogue()
	
func plocka(node):
	if not node:
		return
	if node.has_method("plocka"):
		node.plocka(mike)
		return
	node = node.get_parent()
	if not node.has_method("plocka"):
		return
	node.plocka(mike)

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
