extends StaticBody2D
export(String, FILE, "*.tscn") var arnold_cutscene
func _ready():
	pass
	
func titta(mike):
		mike.talk_to_self("...")
		global.emit_signal("exit", arnold_cutscene)
