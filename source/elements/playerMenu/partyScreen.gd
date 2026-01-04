extends Control


@onready var cursor=$cursor
@onready var classData=$classData
@onready var equipData=$equipData

var charIdx =0

func set_cursor_on_char():
	cursor.position=$display.get_children()[0].position
	pass
