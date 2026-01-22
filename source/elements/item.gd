extends AnimatedSprite2D

@export var itemName: String = "FREE"
@export var points: int = 0
@export var description: String = ""
@export var action: String = "None"

func define_as(item:String="FREE"):
	match item:
		"potion":
			itemName=item
			points = 1
			description= ""
			action= "heal"
			play(item)
		"bomb":
			itemName= item
			points = 1
			description= ""
			action= "bomb"
			play(item)
		"soda":
			itemName=item
			points = 3
			description= ""
			action= "heal"
			play("potion")
		_:
			itemName= "Free"
			points = 0
			description= ""
			action= "None"
			hide()
		
