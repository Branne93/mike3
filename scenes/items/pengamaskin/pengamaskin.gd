extends StaticBody2D

func _ready():
	pass

func used_with_item(item):
	if item == "j3n5":
		global.emit_signal("add_mynt")
		return true
	return false

func titta(mike):
	mike.talk_to_self("En pengamaskin, men jag vet inte hur man använder den.")
