extends AnimatedSprite2D

@export var itemName: String = "FREE"
@export var points: int = 0
@export var description: String = ""
@export var action: String = "None"

func define_as(item:String="FREE"):
	match item:
		"potion":
			itemName=item
			points = 2
			description= "Heal HP"
			action= "heal"
			play(item)
		"bomb":
			itemName= item
			points = 1
			description= "Explode on all foes"
			action= "bomb"
			play(item)
		"soda":
			itemName=item
			points = 4
			description= " Heal HP"
			action= "heal"
			play("potion")
		_:
			itemName= "Free"
			points = 0
			description= "Empty slot"
			action= "None"
			hide()
			
func get_item_desc():
	return str(itemName,":",description)
