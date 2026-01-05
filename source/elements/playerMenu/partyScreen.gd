extends Control


@onready var cursor=$cursor
@onready var classData=$classData
@onready var equipData=$equipData

var charIdx =0

func set_cursor_on_char():
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


func _on_equip_pressed() -> void:
	pass # Replace with function body.
