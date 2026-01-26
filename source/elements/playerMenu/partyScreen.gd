extends Control


@onready var cursor=$cursor
@onready var equipCursor=$equipCursor
@onready var classData=$classData
@onready var equipData=$equipData
@onready var equipOptions= $equipOptions
@onready var selector= $selector
@onready var equipList= $equipList

var charIdx =0
var equipIdx=0
var parentMenu=null

var selectingEquip=false

func set_cursor_on_char():
	var char = $display.get_children()[charIdx]
	cursor.position=$display.get_children()[charIdx].position+Vector2(16,64)
	classData.set_char(char)
	equipData.set_char(char)
	
func set_equip_cursor_on_item():
	equipCursor.global_position=equipData.get_children()[equipIdx].global_position-Vector2(32,0)

func _on_prev_pressed() -> void:	
	charIdx -=1
	if charIdx<0:
		charIdx=$display.get_children().size()-1
	set_cursor_on_char()

func _on_next_pressed() -> void:
	charIdx +=1
	if charIdx>=$display.get_children().size():
		charIdx=0 
	set_cursor_on_char()

func _on_equip_up_pressed() -> void:
	if(selectingEquip):
		equipList.equip_up()
	else:
		equipIdx -=1
		if equipIdx<0:
			equipIdx=equipData.get_children().size()-1 
		set_equip_cursor_on_item()

func _on_equip_down_pressed() -> void:
	if(selectingEquip):
		equipList.equip_down()
	else:
		equipIdx +=1
		if equipIdx>=equipData.get_children().size():
			equipIdx=0 
		set_equip_cursor_on_item()

func change_equip():
	#select party char
	if(equipIdx==0):
		parentMenu.party.party.get_children()[charIdx].set_weapon(equipList.get_equip_selected())
	else:
		parentMenu.party.party.get_children()[charIdx].set_armor(equipList.get_equip_selected())
	set_equip_cursor_on_item()
	equipData.update_display()

func _on_equip_change_pressed() -> void:
	if(selectingEquip):
		change_equip()
		selectingEquip=false
		equipList.hide()
		cursor.show()
	else:
		if(equipIdx==0):
			equipList.set_list(get_parent().party.bag["weapons"])
		else:
			equipList.set_list(get_parent().party.bag["armors"])
		selectingEquip=true
		equipList.show()
		cursor.hide()
