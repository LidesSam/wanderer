extends ColorRect

var idx=0
var list = null
@onready var cursor=$cursor
var displayItems=5


func _ready() -> void:
	for i in displayItems:
		var slot= Label.new()
		slot.text=str("slot:",i)
		slot.position.y=40*i
		$equip.add_child(slot)
	set_cursor_on_pos()
func equip_up():
	if(idx>0):
		idx-=1
	else:
		idx=0
	set_cursor_on_pos()
	
func equip_down():
	if(idx<displayItems-1):
		idx+=1
	else:
		idx=displayItems-1
	set_cursor_on_pos()
	
func set_cursor_on_pos():
	cursor.position.y=16+40*idx
	
func set_list(equipList):
	list= equipList
