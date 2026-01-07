extends Control

var parentMenu= null
@onready var display = $items
@onready var desc = $itemDesc
@onready var currentItem=0


func display_item_data():
	display.get_children().clear()
	var item = load("res://source/elements/item.tscn")
	var x = 0
	var y = 0
	if(parentMenu):
		for i in parentMenu.party.bag:
			var ni = item.instantiate()
			ni.position.x=x*32
			ni.position.y=y*32
			display.add_child(ni)
			desc.text= ni.itemName
			x+=1
			if(x>5):
				x=0
				y+=1
			
		
