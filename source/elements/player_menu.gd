extends TextureRect

var currentTarget=0
var currentTab="party"
var currentTabMode="state"
var currentSlot=0
# Called when the node enters the scene tree for the first time.
func _ready():
	update_cursor_pos_on_party_char()
	gen_display_items()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_gold(gold):
	$header/gold.text= str("GOLD:",gold)
	

func update_cursor_pos_on_party_char():
	var charSelected= $party.get_child(currentTarget)
	$cursor.global_position = charSelected.global_position+Vector2(32,32)
	match currentTabMode:
		"state":
			$main/sideData/classData.set_char(charSelected)
		"equip-and-item":
			pass
		"actions":
			pass
			
	

func update_cursor_pos_on_item():
	$cursor.global_position = $bag/items.get_child(currentTarget).global_position+Vector2(32,32)


func _on_close_btn_pressed():
	hide()
	pass # Replace with function body.


func _on_prev_ptn_pressed() -> void:
	currentTarget-=1
	match currentTab:
		"party":
			while   $party.get_child(currentTarget)==null or $party.get_child(currentTarget).wanderclass=="free":
				currentTarget-=1
				if(currentTarget<0):
					currentTarget=0
			update_cursor_pos_on_party_char()
		"bag":
			pass


func _on_next_btn_pressed() -> void:
	#$party.get_child(currentTarget).modulate="#fff"
	currentTarget+=1
	match currentTab:
		"party":
			while  $party.get_child(currentTarget)==null or $party.get_child(currentTarget).wanderclass=="free":
				currentTarget+=1
				if(currentTarget>2):
					currentTarget=0
			update_cursor_pos_on_party_char()
		
		"bag":
			pass

func gen_display_items():
	var items= get_parent().get_parent().bag
	var i =0
	for item in items:
		var ditem = Label.new()
		ditem.text=item
		$bag/items.add_child(ditem)
		ditem.position= Vector2(i*48,16)
		i+=1
		
	pass

func _on_party_btn_pressed() -> void:
	$main/party.show()
	$main/bag.hide()
	$party.show()
	$bag.hide()
	

func _on_bagbtn_pressed() -> void:
	$main/party.hide()
	$main/bag.show()
	$party.hide()
	$bag.show()
	
	currentTab="state"


func _on_equipbtn_pressed() -> void:
	$main/sideData/classData.hide()
	$main/sideData/equip.show()
	$cursor/spr.show()
	currentTab="equip"
	pass # Replace with function body.


func _on_statebtn_pressed() -> void:
	$main/sideData/classData.show()
	$main/sideData/equip.hide()
	$cursor/spr.hide()
	currentTab="state"
	
	pass # Replace with function body.


func _on_down_btn_pressed() -> void:
	if currentTab=="equip":
		currentSlot+=1
		if currentSlot> $main/sideData/equip.get_child_count()+1:
			currentSlot=0
		
		$equipCursor.global_position =$main/sideData/equip.get_child(currentTarget).global_position+Vector2(32,32)


func _on_up_btn_pressed() -> void:
	if currentTab=="equip":
		currentSlot-=1
		if currentSlot< 0:
			currentSlot=$main/sideData/equip.get_child_count()+1
			
		$equipCursor.global_position =$main/sideData/equip.get_child(currentTarget).global_position+Vector2(32,32)
