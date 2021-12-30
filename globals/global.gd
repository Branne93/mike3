extends Node
signal exit(next_scene)
signal json_signal(string)
signal mike_set_animation(string)
signal set_music(string)
signal start_music(from_position)
signal stop_music
signal activate_old_mike


var pripps_to_lg = 0
var pripps_to_hand_in = 10


#level stuff
var debug = false
var old_mike_active = false
var leave_baren_first_time = true
var visited_baren = false


#mike hem
var mikes_hem_first = true
var mknapp_active = false or debug #false DEBUG
signal pripps_skjuten

#baren
var baren_first_time_leave = true
var blaster_on_floor = false
signal add_pripps_bar


signal add_mynt
signal add_blaster

#obi-ceps
var biceps_solved = false

#ravinen
var planka_set = false
