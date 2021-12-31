extends Node2D
var dialogue = [{"type": "mike", "text" : "Då var vi framme. Gick ju rätt fort."}, 
{"type": "mike_old", "text" : "Dödskalorien. Den hemskaste platsen i universum."},
{"type": "jens", "text" : "Varför är inte lovo goto med?"},
{"type": "dave", "text" : "Branne orkade nog bara gör en sittande sprite åt honom."},
{"type": "dave", "text" : "Men jag har ritningarna! Nu spränger vi skiten!"},
{"type": "function", "function" : "jacob_enter"},
{"type": "jacob", "text" : "Här tar ditt äventyr slut, Mike Tyngdlyfter."},
{"type": "mike", "text" : "Vem är du och hur vet du vem jag är?"},
{"type": "jens", "text" : "Åh nej!"},
{"type": "dave", "text" : "Det är han!"},
{"type": "mike_old", "text" : "Mörkrets furste!"},
{"type": "mike", "text" : "Ni menar att det är...?"},
{"type": "all", "text" : "Jacob of Darkness!"},
{"type": "function", "function" : "jacob_reveal"},
{"type": "mike_old", "text" : "Det här är en fiende ni inte förmår er på. Fly medans jag håller honom"},
{"type": "jacob", "text" : "Skulle du hålla mig, gamling? Universums mörker har gett mig makt du knappt kan ana."},
{"type": "function", "function" : "blast"},
{"type": "jacob", "text" : "Mike... Mike... Kom närmre."},
{"type": "mike", "text" : "Fuck det nä."},
{"type": "jacob", "text" : "Det är... Superviktigt... Ta av mig... Masken..."},
{"type": "mike", "text" : "Fan, got time to talk, got time to unmask."},
{"type": "jacob", "text" : "Riktigt rude... Även när jag är döende måste jag göra allt..."},
{"type": "function", "function" : "unmask"},
{"type": "jacob", "text" : "Precis som Obi-ceps var jag också en mike, med mitt eget äventyr"},
{"type": "jens", "text" : "Va? Varför berättade du aldrig det här Obi-ceps?"},
{"type": "mike_old", "text" : "Trodde det var uppenbart? Sluta störa nu jag vill höra mer."},
{"type": "jacob", "text" : "Yeah bara avbryt mig när jag är döende och ska berätta superviktiga grejer. Snyggt."},
{"type": "jacob", "text" : "Det har funnits en obräknerlig mängd Mikes, men en efter en har de misslyckats."},
{"type": "jacob", "text" : "Jag blev förslavad ev en uråldrig varelse, en varelse vars hat har överstigit Mikeversumet..."},
{"type": "jacob", "text" : "Den förste av oss..."},
{"type": "jacob", "text" : "När du sköt mig så bröts förtrollningen, Men du måste fly! Fort innan-"},
{"type": "function", "function" : "reveal_god_mike"},
{"type": "god", "text" : "Äntligen, äntligen, äntligen."},
{"type": "mike_old", "text" : "Vad i hela-"},
{"type": "god", "text" : "Käften! Du fattar inte hur länge jag har väntat på att få gymma. Ända sedan dave låg bakis i min hall."},
{"type": "god", "text" : "Men så fort jag löste alla problemen så tynade allt bort, jag fick aldrig gymma."},
{"type": "god", "text" : "En oändlig repetition av att försöka ta sig till gymmet men aldrig komma dit"},
{"type": "god", "text" : "Med hjälp av makten hos pripps bröt jag mig loss och såg andra verkligheter."},
{"type": "god", "text" : "Det fanns andra Mike som förgäves också försökte ta sig till gymmet."},
{"type": "god", "text" : "Jag såg också lösningen, den andra konstanten i mikeversumet."},
{"type": "god", "text" : "Dave."},
{"type": "all", "text" : "Dave!?"},
{"type": "jens", "text" : "Du menar inte D4-V3?"},
{"type": "dave", "text" : "Jo det gör han nog för jag är också en Dave."},
{"type": "god", "text" : "Dave är den enda andra varelsen som kan bryta mikeversumet. Det är därför han hela tiden bryte den fjärde väggen."},
{"type": "god", "text" : "Så jag fann min lösning."},
{"type": "function", "function" : "dave_reveal"},
{"type": "god", "text" : "Nu har jag äntligen samlat alla dave i mikeversumet. Så ni andra behövs inte längre."},
{"type": "function", "function" : "lightning"},
{"type": "dave", "text" : "Woah wtf du bara dödade dem?"},
{"type": "god", "text" : "Jag vill bara gymma för i helvette dave. Fuck you, sluta vara jobbig!"},
{"type": "god", "text" : "En sista trollformel sen ska jag packa mina gymkläder."},
{"type": "function", "function" : "transform"},
{"type": "god", "text" : "Sådärja. Varför skulle någon vilja spela det spelet?"},
{"type": "god", "text" : "Det är äntligen över."}
]
export(String, FILE, "*.mid") var midi_music
var active = true
var index = 0
signal function_finished

func _ready():
	$mike/CanvasLayer/actions.hide()
	$mike/Sprite.flip_h = true
	$Mike_Old/Sprite.flip_h = true
	$mike/mouse_control.active = false
	global.emit_signal("set_music", midi_music)
	global.emit_signal("start_music")
	$AnimationPlayer.play("start")
	next_dialogue()

func _input(event):
		if active and event.is_action_pressed("ui_accept"):
			next_dialogue()
		
func next_dialogue():
	if index >= len(dialogue):
		hide_all()
		$AnimationPlayer.play("slut")
		active = false
		return
	var dialogue_dict = dialogue[index]
	index += 1
	if dialogue_dict["type"] == "jens":
		jens_dialogue(dialogue_dict["text"])
	if dialogue_dict["type"] == "dave":
		dave_dialogue(dialogue_dict["text"])
	if dialogue_dict["type"] == "mike":
		mike_dialogue(dialogue_dict["text"])
	if dialogue_dict["type"] == "mike_old":
		mike_old_dialogue(dialogue_dict["text"])
	if dialogue_dict["type"] == "jacob":
		jacob_dialogue(dialogue_dict["text"])
	if dialogue_dict["type"] == "all":
		all_dialogue(dialogue_dict["text"])
	if dialogue_dict["type"] == "god":
		god_mike_dialogue(dialogue_dict["text"])
	if dialogue_dict["type"] == "function":
		run_function(dialogue_dict["function"])
		
func run_function(function_name):
	if function_name == "jacob_enter":
		jacob_enter()
	elif function_name == "jacob_reveal":
		jacob_reveal()
	elif function_name == "blast":
		blast()
	elif function_name == "unmask":
		unmask()
	elif function_name == "reveal_god_mike":
		reveal_god_mike()
	elif function_name == "dave_reveal":
		dave_reveal()
	elif function_name == "lightning":
		lightning()
	elif function_name == "transform":
		transform()
		
func jacob_enter():
	active = false
	jacob_dialogue("Inte så fort!")
	$jacobofdarkness.target_coord = $Position2D.position
	yield($jacobofdarkness, "framme")
	active = true
	
func jacob_reveal():
	jacob_dialogue("Exakt, era öden är förseglade. Ge upp nu medans ni kan!")
	$jacobofdarkness.reveal()
	
func blast():
	hide_all()
	$mike/AnimationPlayer.play("pang")
	$jacobofdarkness/AnimationPlayer.play("skjuten")
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	$jacobofdarkness/AnimationPlayer.play("döende")
	$mike/AnimationPlayer.play("stå")
	
func unmask():
	hide_all()
	$jacobofdarkness/AnimationPlayer.play("unmasked")
	all_dialogue("Megaflämt!")
	
func reveal_god_mike():
	hide_all()
	$AnimationPlayer.play("reveal_god_mike")
	yield($AnimationPlayer, "animation_finished")
	
func dave_reveal():
	hide_all()
	$AnimationPlayer.play("daves_lowered")
	yield($AudioStreamPlayer, "finished")
	
func lightning():
	$lightning.play()
	$AnimationPlayer.play("lightning")
	$Timer.start()
	yield($Timer, "timeout")
	$j3ns.hide()
	$Mike_Old.hide()
	$mike.hide()
	$jacobofdarkness.hide()
	yield($AnimationPlayer, "animation_finished")
	
func transform():
	$lightning.play()
	$AnimationPlayer.play("lightning")
	$Timer.start()
	yield($Timer, "timeout")
	$d4v3.hide()
	$Node2D.hide()
	$Sprite.show()
	yield($AnimationPlayer, "animation_finished")
	
func hide_all():
	$d4v3.hide_pratbubbla()
	$j3ns.hide_pratbubbla()
	$Mike_Old.hide_pratbubbla()
	$mike.hide_pratbubbla()
	$jacobofdarkness.hide_pratbubbla()
	$god_mike.hide_pratbubbla()
	
func jens_dialogue(text):
	hide_all()
	$j3ns.set_text(text)
	$j3ns.show_pratbubbla()
	
func all_dialogue(text):
	var list = [$d4v3, $mike, $Mike_Old, $j3ns] 
	hide_all()
	for item in list:
		item.set_text(text)
		item.show_pratbubbla()
	
func dave_dialogue(text):
	hide_all()
	$d4v3.set_text(text)
	$d4v3.show_pratbubbla()
	
func mike_dialogue(text):
	hide_all()
	$mike.set_text(text)
	$mike.show_pratbubbla()
	
func mike_old_dialogue(text):
	hide_all()
	$Mike_Old.set_text(text)
	$Mike_Old.show_pratbubbla()
	
func jacob_dialogue(text):
	hide_all()
	$jacobofdarkness.set_text(text)
	$jacobofdarkness.show_pratbubbla()

func god_mike_dialogue(text):
	hide_all()
	$god_mike.set_text(text)
	$god_mike.show_pratbubbla()
