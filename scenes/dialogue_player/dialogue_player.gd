extends Node
export(String, FILE, "*.json") var dialogue_file
export(NodePath) var mike_path
var mike
var other
var speech_menu

var dialogue = {}
var current = {}
var active = false


func _ready():
	mike = get_node(mike_path)
	speech_menu = mike.get_speech_menu()
	other = get_parent()
	index_dialogue()
	
func _input(event):
	if active and event.is_action_pressed("ui_accept"):
		next_dialogue()
	
func index_dialogue():
	dialogue = load_dialogue(dialogue_file)
	current = dialogue[dialogue.keys()[0]]
	
func start_dialogue():
	var mouse_control = mike.get_node("mouse_control")
	speech_menu.connect("menu_choice", self, "select_option")
	mouse_control.active = false
	active = true
	var type = current["type"]
	if type == "mike":
		mike_prata()
	elif type == "other":
		other_prata()
	elif type == "option":
		show_option()

func next_dialogue():
	hide_all()
	if current["next"] == "done":
		finish_dialogue()
	else:
		current = dialogue[current["next"]]
		var type = current["type"]
		if type == "mike":
			mike_prata()
		elif type == "other":
			other_prata()
		elif type == "option":
			show_option()
		elif type == "signal":
			global.emit_signal("json_signal", current["content"])
			next_dialogue()
		
func finish_dialogue():
	active = false
	current = dialogue["first"]
	var mouse_control = mike.get_node("mouse_control")
	speech_menu.disconnect("menu_choice", self, "select_option")
	mouse_control.active = true

func load_dialogue(file_path):
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		return parse_json(file.get_as_text())
		
func mike_prata():
	mike.set_text(current["content"])
	mike.show_pratbubbla()
func other_prata():
	other.set_text(current["content"])
	other.show_pratbubbla()
	
func show_option():
	speech_menu.set_options(current["options"])
	speech_menu.show()
	active = false
	
func select_option(option):
	current["next"] = current["next_option"][option]
	active = true
	next_dialogue()
	
func hide_all():
	mike.hide_pratbubbla()
	if other.has_method("hide_pratbubbla"):
		other.hide_pratbubbla()
	speech_menu.hide()
