extends Node2D
export var flipped = false

func _ready():
	$Sprite.flip_h = flipped
	
func set_text(text):
	$Sprite/Label.text = text
