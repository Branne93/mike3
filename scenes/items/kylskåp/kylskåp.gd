extends StaticBody2D

func _ready():
	$pripps4/CollisionShape2D.disabled = true
	pass

func used_with_item(item):
	if item == "d4v3":
		if not inventory_flags.items_collected.has("pripps4"):
			$pripps4/CollisionShape2D.disabled = false
			$pripps4.show()
		$Sprite.frame = 1
		return true
	return false

func titta(mike):
	mike.talk_to_self("Ett veganskt kylskåp, jag är inte veg nog för att öppna den.")
