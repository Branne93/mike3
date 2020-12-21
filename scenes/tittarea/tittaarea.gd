extends StaticBody2D
onready var collisionShape2D = get_node("CollisionShape2D")
export(String) var titta_text = ""
func _ready():
	pass

func titta(mike):
	if titta_text != "":
		mike.talk_to_self(titta_text)
