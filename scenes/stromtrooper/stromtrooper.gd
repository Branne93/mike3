extends KinematicBody2D
var target_coord
const buffer_distance = 50
const speed = 70

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
		
func set_target_coord(coord):
	target_coord = coord
	
func used_with_item(item):
	if item == "blaster":
		$AnimationPlayer.play("dö")
		$AudioStreamPlayer.play()
		global.emit_signal("mike_set_animation", "pang")
		$Timer.start()
		global.biceps_solved = true
		yield($Timer, "timeout")
		global.emit_signal("exit", "res://scenes/levels/old_mike_hem/old_mike_hem.tscn")
		return true
	return false

func set_text(text):
	$pratbubbla.set_text(text)
func show_pratbubbla():
	$pratbubbla.show()
func hide_pratbubbla():
	$pratbubbla.hide()
