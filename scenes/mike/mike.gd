extends KinematicBody2D

export(NodePath) var pathfinder_path
export var speed = 120

var pathfinder
var path = null
var path_index = 0

signal path_finished

func _ready():
	pathfinder = get_node(pathfinder_path)
	$mouse_control.connect("go_to", self, "find_path")
	$Camera2D.limit_bottom = 768
	set_animation("stå")
	global.connect("mike_set_animation", self, "set_animation")
	$CanvasLayer/Inventory.update_items()

func _physics_process(_delta):
	if not path:
		return
	var target = path[path_index]
	if $CollisionShape2D.global_position.distance_to(target) < 1:
		path_index = wrapi(path_index + 1, 0, path.size())
		target = path[path_index]
	var direction = (target - $CollisionShape2D.global_position).normalized()
	$Sprite.flip_h = direction.x < 0
	move_and_slide(direction * speed)
	if $CollisionShape2D.global_position.distance_to(path[-1]) < 25: 
		path = null
		set_animation("stå")
		emit_signal("path_finished")
		
func find_path(point):
	if not $mouse_control.active:
		return
	path_index = 0
	path = pathfinder.get_simple_path($CollisionShape2D.global_position, point, false)
	$AnimationPlayer.play("gå")

func set_animation(name):
	$AnimationPlayer.play(name)
	if name == "tänk" or name == "stå":
		path = null

func set_text(text):
	$pratbubbla.set_text(text)
func show_pratbubbla():
	$pratbubbla.show()
func hide_pratbubbla():
	$pratbubbla.hide()
func talk_to_self(text):
	set_text(text)
	$pratbubbla.show()
	$pratbubbla/Timer.start()
	yield($pratbubbla/Timer, "timeout")
	$pratbubbla.hide()
	
func get_speech_menu():
	return $CanvasLayer/speech_menu

