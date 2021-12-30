extends KinematicBody2D
var target_coord
const buffer_distance = 50
const speed = 70
signal framme

func _ready():
	pass

func _physics_process(_delta):
	if target_coord:
		walk_to_target()
	
func walk_to_target():
	if $CollisionShape2D.global_position.distance_to(target_coord) > buffer_distance:
		var goal = target_coord
		var direction = (goal - $CollisionShape2D.global_position).normalized()
		$Sprite.flip_h = direction.x < 0
		move_and_slide(direction * speed)
		$AnimationPlayer.play("gå")
	else:
		$AnimationPlayer.play("stå")
		target_coord = null
		emit_signal("framme")
		
func set_target_coord(coord):
	target_coord = coord
	
func reveal():
	$Sprite.hide()
	$Sprite2.show()

func set_text(text):
	$pratbubbla.set_text(text)
func show_pratbubbla():
	$pratbubbla.show()
func hide_pratbubbla():
	$pratbubbla.hide()
