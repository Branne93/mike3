extends Control
export(NodePath) var inventory_path

signal action(action)
signal disable_walk
signal enable_walk

var inventory


func _ready():
	$prata.connect("button_down", self, "prata")
	$titta.connect("button_down", self, "titta")
	$plocka.connect("button_down", self, "plocka")
	$puttadra.connect("button_down", self, "putta")
	$inventory.connect("button_down", self, "inventory_button")
	inventory = get_node(inventory_path)
	for child in get_children():
		child.connect("mouse_entered", self, "disable_walk")
		child.connect("mouse_exited", self, "enable_walk")

func prata():
	emit_signal("action", "prata")
func titta():
	emit_signal("action", "titta")
func plocka():
	emit_signal("action", "plocka")
func putta():
	emit_signal("action", "putta")
func enable_walk():
	emit_signal("enable_walk")
func disable_walk():
	emit_signal("disable_walk")
	
func inventory_button():
	inventory.open_close()
	if inventory.open:
		$inventory.icon = load("res://assets/inventory_open.png")
	else:
		$inventory.icon = load("res://assets/inventory_closed.png")
