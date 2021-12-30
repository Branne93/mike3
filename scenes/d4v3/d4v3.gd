extends KinematicBody2D
export(NodePath) var mikepath
export var distance_from_mike = 250
onready var mike = get_node(mikepath)
onready var speed = mike.speed

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var mike_position = mike.get_node("CollisionShape2D").global_position
	if $feet_point.global_position.distance_to(mike_position) > distance_from_mike:
		var goal = mike_position
		if mike.get_node("Sprite").flip_h:
			goal.x += distance_from_mike
		else:
			goal.x -= distance_from_mike
		var direction = (goal - $feet_point.global_position).normalized()
		$Sprite.flip_h = direction.x < 0
		move_and_slide(direction * speed)
		
func set_text(text):
	$pratbubbla.set_text(text)
func show_pratbubbla():
	$pratbubbla.show()
func hide_pratbubbla():
	$pratbubbla.hide()
