extends StaticBody2D

func _ready():
	pass

func used_with_item(item):
	if item == "mynt":
		global.emit_signal("add_pripps_bar")
		return true
	return false

func set_text(text):
	$pratbubbla.set_text(text)
func show_pratbubbla():
	$pratbubbla.show()
func hide_pratbubbla():
	$pratbubbla.hide()
