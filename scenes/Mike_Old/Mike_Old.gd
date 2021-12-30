extends KinematicBody2D
export(NodePath) var mikepath
export var distance_from_mike = 500
onready var mike = get_node(mikepath)
onready var speed = mike.speed
onready var active = global.old_mike_active

func _ready():
	global.connect("activate_old_mike", self, "activate")

func _physics_process(_delta):
	var mike_position = mike.get_node("CollisionShape2D").global_position
	if active and $point_feet.global_position.distance_to(mike_position) > distance_from_mike:
		var goal = mike_position
		if mike.get_node("Sprite").flip_h:
			goal.x += distance_from_mike
		else:
			goal.x -= distance_from_mike
		var direction = (goal - $point_feet.global_position).normalized()
		$Sprite.flip_h = direction.x < 0
		move_and_slide(direction * speed)
		$AnimationPlayer.play("gå")
	else:
		$AnimationPlayer.play("stå")
func set_text(text):
	$pratbubbla.set_text(text)
func show_pratbubbla():
	$pratbubbla.show()
func hide_pratbubbla():
	$pratbubbla.hide()
func activate():
	global.old_mike_active = true
	active = true
