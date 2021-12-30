extends Node2D

var dialogue = [{"type": "jens", "text" : "Åh nej! Vi är under attack!"}, 
{"type": "jens", "text" : "det måste vara det fruktade GYMDIMPERIET"},
{"type": "dave", "text" : "vafan är det här? Varför är det en rymdgrej nu?"},
{"type": "jens", "text" : "De är nog ute efter ritningarna som vi stal"},
{"type": "dave", "text" : "Det låter häftigt, hur lyckades vi med det?"},
{"type": "jens", "text" : "En bra fråga, för en annan gång."},
{"type": "jens", "text" : "Nu måste vi fly till den där skitplaneten. Skynda!"}]

var index = 0
var active = true
#const next_scene = "res://scenes/cutscenes/ökenkrasch/ökenkrasch.tscn"
export(String, FILE, "*.tscn") var next_scene

func _ready():
	$mike/CanvasLayer/actions.hide()
	global.emit_signal("set_music", "res://assets/musik/EP4__Imperial_Attack.mid")
	global.emit_signal("start_music")
	next_dialogue()
	
func _input(event):
		if active and event.is_action_pressed("ui_accept"):
			next_dialogue()
		
func next_dialogue():
	if index >= len(dialogue):
		active = false
		$mike.position += Vector2(5000, 0)
		$j3ns.hide_pratbubbla()
		$d4v3.hide_pratbubbla()
		$jacobofdarkness.set_target_coord($Position2D.global_position)
		$stromtrooper.set_target_coord($Position2D2.global_position)
		$stromtrooper2.set_target_coord($Position2D3.global_position)
		$Timer.start()
		yield($Timer, "timeout")
		global.emit_signal("stop_music")
		global.emit_signal("exit", next_scene)
		return
	var dialogue_dict = dialogue[index]
	index += 1
	if dialogue_dict["type"] == "jens":
		jens_dialogue(dialogue_dict["text"])
	if dialogue_dict["type"] == "dave":
		dave_dialogue(dialogue_dict["text"])
	
func jens_dialogue(text):
	$j3ns.set_text(text)
	$j3ns.show_pratbubbla()
	$d4v3.hide_pratbubbla()
	
func dave_dialogue(text):
	$d4v3.set_text(text)
	$d4v3.show_pratbubbla()
	$j3ns.hide_pratbubbla()
