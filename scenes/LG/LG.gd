extends StaticBody2D

var dialogue_player
var dialogue_player2
export(String, FILE, "*.tscn") var end

func _ready():
	for child in get_children():
		if child.name == "dialogue_player":
			dialogue_player = child
		if child.name == "dialogue_player2":
			dialogue_player2 = child
	if global.pripps_to_hand_in == 5:
		dialogue_player.dialogue_file = "res://assets/dialogue_data/baren/LG2.json"
		dialogue_player.index_dialogue()
	
func titta(mike):
	mike.talk_to_self("Ser ut att vara en slotssmuggglare från planeten Sundsvall")
func used_with_item(item):
	if item == "mike_old":
		dialogue_player2.start_dialogue()
		global.pripps_to_hand_in = 5
		dialogue_player.dialogue_file = "res://assets/dialogue_data/baren/LG2.json"
		dialogue_player.index_dialogue()
		yield(dialogue_player2, "dialogue_finished")
		if global.pripps_to_hand_in - global.pripps_to_lg == 0:
			global.emit_signal("exit", end)
		return true
	elif item == "pripps":
		lamna_pripps()
		return true
	return false

func lamna_pripps():
	global.pripps_to_lg  +=1
	for item in inventory_flags.items: #remove a pripps, dont care which
		if "pripps" in item:
			inventory_flags.items.erase(item)
			break
	inventory_flags.emit_signal("items_updated")
	if global.pripps_to_hand_in - global.pripps_to_lg == 0:
		global.emit_signal("exit", end)
	else:
		var text = "Det var %d pripps, bara %d kvar!"
		set_text(text % [global.pripps_to_lg, global.pripps_to_hand_in - global.pripps_to_lg])
		$pratbubbla.show()
		$pratbubbla/Timer.start()
		yield($pratbubbla/Timer, "timeout")
		$pratbubbla.hide()

	
func set_text(text):
	$pratbubbla.set_text(text)
func show_pratbubbla():
	$pratbubbla.show()
func hide_pratbubbla():
	$pratbubbla.hide()
