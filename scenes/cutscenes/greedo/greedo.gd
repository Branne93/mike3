extends Node2D
var is_walking = true
var index = 0
var greedo_speed = 200
export(String, FILE, "*.tscn") var baren

var dialogue = [{"type": "greedo", "text" : "Inte så snabbt, Love Goat!"}, 
{"type": "lg", "text" : "Va? Jag rörde mig inte?"},
{"type": "greedo", "text" : "Du borde tänka efter innan du dumpar en last med slots spice, nu är det ett pris på ditt huvud."},
{"type": "lg", "text" : "Det var inte mitt fel, de tog mig i tullen!"},
{"type": "greedo", "text" : "Ah det är vad alla säger. Ska hälsa från Jabba, \"Maclunky\"."},
{"type": "lg", "text" : "Va?"},
{"type": "greedo", "text" : "Maclunky!"},
{"type": "lg", "text" : "En gång till."},
{"type": "greedo", "text" : "M A C L U N K Y"},
{"type": "lg", "text" : "Nepp. Står helt still. En sista gång?"},
{"type": "greedo", "text" : "Maclunky, det betyder typ \"Gött att du dör\""},
{"type": "gun", "text" : "Du föll nyss för en av de klassiska tricken, berätta aldrig lore för en Sundsvallare!"}
]

func _ready():
	$AnimationPlayer.play("gå")
	$Timer.connect("timeout", self, "timeout")
	$Timer.start(4.0)

func _process(delta):
	if is_walking:
		$greedo.position.x += greedo_speed * delta
		
func _input(event):
	if not is_walking and event.is_action_pressed("ui_accept"):
		next_dialogue()
		
func next_dialogue():
	if index < dialogue.size():
		var dialogue_dict = dialogue[index]
		if dialogue_dict["type"] == "gun":
			$gun.show()
			dialogue_dict["type"] = "lg"
		if dialogue_dict["type"] == "lg":
			lgprat(dialogue_dict["text"])
		if dialogue_dict["type"] == "greedo":
			greedoprat(dialogue_dict["text"])
		index += 1
	else:
		$AudioStreamPlayer.play()
		global.blaster_on_floor = true
		global.emit_signal("exit", baren)

func timeout():
	is_walking = false
	$AnimationPlayer.play("stå")
	next_dialogue()
	
func lgprat(text):
	$LGprat.set_text(text)
	$Greedoprat.hide()
	$LGprat.show()
	
func greedoprat(text):
	$Greedoprat.set_text(text)
	$LGprat.hide()
	$Greedoprat.show()
