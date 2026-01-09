extends Control

var parentMenu= null
@onready var display = $items
@onready var desc = $itemDesc
@onready var cursor = $cursor
@onready var itemIdx=0


func display_item_data():
	for child in display.get_children():
		child.queue_free()
	var item = load("res://source/elements/item.tscn")
	var x = 0
	var y = 0
	if(parentMenu):
		for i in parentMenu.party.bag:
			var ni = item.instantiate()
			ni.position.x=x*32
			ni.position.y=y*32
			print("itm:ni:",ni)
			print("itm:defas:",i.itemName)
			ni.define_as(i.itemName)
			display.add_child(ni)
			
			x+=1
			if(x>5):
				x=0
				y+=1
		set_cursor_on_item()
	
func set_cursor_on_item():
	var currentItem = display.get_children()[itemIdx]
	cursor.global_position= currentItem.global_position+Vector2(8,16)
	desc.text=currentItem.description


func _on_prev_pressed() -> void:	
	itemIdx -=1
	if itemIdx<0:
		itemIdx=display.get_children().size()-1
	set_cursor_on_item()


func _on_next_pressed() -> void:
	itemIdx +=1
	if itemIdx>=display.get_children().size():
		itemIdx=0 
	set_cursor_on_item()
