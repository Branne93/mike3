extends Node
export(String, FILE, "*.json") var dialogue_file
export(NodePath) var mike_path
export(NodePath) var jens_path
export(NodePath) var dave_path
export(NodePath) var mike_old_path
onready var mike = get_node(mike_path)
var jens
var dave
var mike_old
var other
var speech_menu

var dialogue = {}
var current = {}
var active = false

signal dialogue_finished


func _ready():
	if jens_path:
		jens = get_node(jens_path)
	if dave_path:
		dave = get_node(dave_path)
	if mike_old_path:
		mike_old = get_node(mike_old_path)
	speech_menu = mike.get_speech_menu()
	other = get_parent()
	index_dialogue()
	
func _input(event):
	if active and event.is_action_pressed("ui_accept"):
		next_dialogue()
	
func index_dialogue():
	dialogue = {}
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
	elif type == "j3n5":
		jens_prata()
	elif type == "d4v3":
		dave_prata()
	elif type == "mike_old":
		mike_old_prata()
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
		elif type == "j3n5":
			jens_prata()
		elif type == "d4v3":
			dave_prata()
		elif type == "mike_old":
			mike_old_prata()
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
	emit_signal("dialogue_finished")

func load_dialogue(file_path):
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		return parse_json(file.get_as_text())
		
func mike_prata():
	mike.set_text(current["content"])
	mike.show_pratbubbla()
func jens_prata():
	jens.set_text(current["content"])
	jens.show_pratbubbla()
func dave_prata():
	dave.set_text(current["content"])
	dave.show_pratbubbla()
func mike_old_prata():
	mike_old.set_text(current["content"])
	mike_old.show_pratbubbla()
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
	jens.hide_pratbubbla()
	dave.hide_pratbubbla()
	if mike_old:
		mike_old.hide_pratbubbla()
	if other.has_method("hide_pratbubbla"):
		other.hide_pratbubbla()
	speech_menu.hide()
