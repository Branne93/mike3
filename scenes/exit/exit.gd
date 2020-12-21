extends Area2D
export(String) var new_scene
export(NodePath) var position_after_exit
onready var collisionShape2D = get_node("CollisionShape2D")

var exit_position

func _ready():
	connect("body_entered", self, "trigger")
	exit_position = get_node(position_after_exit).position
func trigger(node):
	if node.name == "mike":
		print("going to " + new_scene)
		global.emit_signal("exit", new_scene, node)
		node.position = exit_position
		node.path = null
		global.emit_signal("mike_set_animation", "stå")
#exit(next_scene_packed, mike, mike_new_pos)
