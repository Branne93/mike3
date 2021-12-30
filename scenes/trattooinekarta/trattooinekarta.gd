extends Control
export(String, FILE, "*.tscn") var baren
export(String, FILE, "*.tscn") var mikes_hem
export(String, FILE, "*.tscn") var utanfor_biceps
export(String, FILE, "*.tscn") var hos_biceps
export(String, FILE, "*.tscn") var ravinen

export(String, FILE, "*.tscn") var greedo

func _ready():
	$staden.connect("button_down", self, "go_to_staden")
	$mike_hem.connect("button_down", self, "go_to_hem")
	$biceps_hus.connect("button_down", self, "go_to_biceps")
	$ravinen.connect("button_down", self, "go_to_ravinen")


func go_to_staden():
	hide()
	global.visited_baren = true
	global.emit_signal("stop_music")
	global.emit_signal("exit", baren)
	

func go_to_hem():
	hide()
	if not check_baren():
		global.emit_signal("exit", mikes_hem)
	
#terrible solution
func check_baren():
	if global.visited_baren and global.leave_baren_first_time:
		global.leave_baren_first_time = false
		global.emit_signal("exit", greedo)
		return true
	return false

func go_to_biceps():
	hide()
	if check_baren():
		return
	global.emit_signal("stop_music")
	if global.biceps_solved:
		global.emit_signal("exit", hos_biceps)
	else:
		global.emit_signal("exit", utanfor_biceps)
		
func go_to_ravinen():
	hide()
	if check_baren():
		return
	global.emit_signal("stop_music")
	global.emit_signal("exit", ravinen)
