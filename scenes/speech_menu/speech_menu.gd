extends Control
var active = false
signal menu_choice(choice)

func _ready():
	$menyval1.connect("button_down", self, "choice_1")
	$menyval2.connect("button_down", self, "choice_2")
	$menyval3.connect("button_down", self, "choice_3")
	
func choice_1():
	emit_signal("menu_choice", 0)
func choice_2():
	emit_signal("menu_choice", 1)
func choice_3():
	emit_signal("menu_choice", 2)
	
func set_options(options):
	$menyval1.text = options[0]
	if options.size() > 2:
		$menyval2.text = options[1]
		$menyval3.text = options[2]
		return
	elif options.size() > 1:
		$menyval2.text = options[1]
		$menyval3.hide()
	else:
		$menyval2.hide()
		$menyval3.hide()
