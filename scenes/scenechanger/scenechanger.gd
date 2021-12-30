extends Node

export(NodePath) var root_nodepath


var current_scene = null
onready var root_node = get_node(root_nodepath)

#Is it possible to overload this with more arguments?
func set_scene(scene_file):
	if scene_file == null:
		print("Cant change scene to null!")
		return
	var animation_player = root_node.get_node("AnimationPlayer")
	if current_scene != null:
		animation_player.play("fade_in")
		yield(animation_player, "animation_finished")
		#current_scene.disconnect("exit", self, "set_scene")
		current_scene.queue_free()
		remove_child(current_scene)
	var new_scene = load(scene_file).instance()
	add_child(new_scene)
	animation_player.play("fade_out")
	current_scene = new_scene
	#current_scene.connect("exit", self, "set_scene")
