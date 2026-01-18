extends Control


@onready var cursor=$cursor
@onready var equipCursor=$equipCursor
@onready var classData=$classData
@onready var equipData=$equipData
@onready var equipOptions= $equipOptions
@onready var selector= $selector

var charIdx =0
var equipIdx=0
var parentMenu=null

func set_cursor_on_char():
	var char = $display.get_children()[charIdx]
	cursor.position=$display.get_children()[charIdx].position+Vector2(16,64)
	classData.set_char(char)
	pass
	
func set_equip_cursor_on_item():
	var char = $display.get_children()[charIdx]
	cursor.position=$display.get_children()[charIdx].position+Vector2(16,64)
	classData.set_char(char)
	pass


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
	equipIdx +=1
	if equipIdx>=$display.get_children().size():
		equipIdx=0 
	set_equip_cursor_on_item()


func _on_equip_down_pressed() -> void:
	equipIdx +=1
	if equipIdx>=$display.get_children().size():
		equipIdx=0 
	set_equip_cursor_on_item()
