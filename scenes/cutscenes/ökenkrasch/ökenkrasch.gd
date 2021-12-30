extends Node2D
var dialogue = [{"type": "dave", "text" : "Rejält trappsteg det där."}, 
{"type": "jens", "text" : "Vart är vi nu? Det är ju fullt av sand."},
{"type": "dave", "text" : "Jag hatar sand."},
{"type": "jens", "text" : "Det här stället suger ju. Om det fanns ett trattigt centrum i universum hade det varit det här."},
{"type": "dave", "text" : "Enligt mina databser är det planeten Trattooine. Fyndigt."},
{"type": "jens", "text" : "Man måste ju vara helt jävla dum i huvudet om man väljer att bo på en sandplanet"},
{"type": "jens", "text" : "Jag ser en inföding därborta. Han kanske kan hjälpa oss härifrån"}]

var index = 0
var active = true
export(String, FILE, "*.tscn") var next_scene

func _ready():
	$mike/CanvasLayer/actions.hide()
	global.emit_signal("set_music", "res://assets/musik/EP4__The_Dune_Sea_Of_Tatooine-Jawa_Sandcrawler.mid")
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
