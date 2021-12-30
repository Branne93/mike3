extends StaticBody2D

func _ready():
	pass

func titta(mike):
	mike.talk_to_self("Jävlar en flygande pripps! Om jag bara kunde nå den på något sätt...")
	
func used_with_item(item):
	if item == "blaster":
		global.emit_signal("pripps_skjuten")
		return true
	return false
