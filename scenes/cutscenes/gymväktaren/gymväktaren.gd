extends Node2D
export(String, FILE, "*.tscn") var next_scene
export(String, FILE, "*.mid") var midi_music
var index = 0
var dialogue_started = false
var dialogue = [{"type" : "mike", "text" : "En vacker dag kommer jag lämna den här planeten..."},
{"type" : "arnold", "text": "Miiike... Miiiiike.... MIKE!"},
{"type" : "mike", "text" : "Jisses Amalia, ett spöke! Kristi kraft betvinga dig!"},
{"type" : "arnold", "text" : "Du har glömt dig själv, och därmed har du glömt mig"},
{"type" : "mike", "text" : "Kan det vara... Gymväktaren!? Men jag trodde han var en myt!"},
{"type" : "arnold", "text" : "Mycket har gjorts för att dölja min natur, men min existens på detta plan är nu mer allt för svag"},
{"type" : "arnold", "text" : "Du, Mike, är den utvalde."},
{"type" : "mike", "text" : "Men jag är bara Mike!"},
{"type" : "arnold", "text" : "Du måste finna Obi-Ceps Kenobi. Med hans hjälp kan du återställa universum."},
{"type" : "mike", "text" : "Ja, ja självklart! Du menar möjligtvis inte gamle galne Biceps Kenobi?"},
{"type" : "arnold", "text" : "Jo densamme, en vän från förr."},
{"type" : "mike", "text" : "Men, hur finner jag honom? Det är en superstor planet och min skateboard är i verkstaden!"},
{"type" : "arnold", "text" : "Jag skänker dig kraften att använda m-knappen. Använd den väl."},
{"type" : "arnold", "text" : "Gå nu, och lyft till det extrema!"},
{"type" : "mike", "text" : "Jag ska! Tack så mycket fader!"}
]

func _ready():
	$mike/CanvasLayer/actions.hide()
	$mike.find_path($Position2D.global_position)
	$mike/mouse_control.active = false
	#global.emit_signal("set_music", "midi_music")
	global.emit_signal("set_music", "res://assets/musik/theforce.mid")
	print("music set to "  + midi_music)
	#print("type is: " + typeof(midi_music))
	global.emit_signal("start_music")
	$Timer.start()
	yield($Timer, "timeout")
	dialogue_started = true
	next_dialogue()

func _input(event):
		if event.is_action_pressed("ui_accept") and dialogue_started:
			if index == 1:
				$AnimationPlayer.play("tona_in_väktare")
				yield($AnimationPlayer, "animation_finished")
				$mike/Sprite.flip_h = true
			next_dialogue()

func next_dialogue():
	if index >= len(dialogue):
		$gymvaktare_spoke.hide_pratbubbla()
		$mike.hide_pratbubbla()
		global.mknapp_active = true
		global.emit_signal("stop_music")
		global.emit_signal("exit", next_scene)
		return
	var dialogue_dict = dialogue[index]
	index += 1
	if dialogue_dict["type"] == "mike":
		mike_dialogue(dialogue_dict["text"])
	else:
		vaktare_dialogue(dialogue_dict["text"])
	
func vaktare_dialogue(text):
	$gymvaktare_spoke.set_text(text)
	$gymvaktare_spoke.show_pratbubbla()
	$mike.hide_pratbubbla()
	
func mike_dialogue(text):
	$mike.set_text(text)
	$mike.show_pratbubbla()
	$gymvaktare_spoke.hide_pratbubbla()
