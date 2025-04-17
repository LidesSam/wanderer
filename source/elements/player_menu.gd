extends TextureRect

var currentTarget=0
var currentTab="party"
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
	$cursor.global_position = $party.get_child(currentTarget).global_position+Vector2(32,32)
	

func update_cursor_pos_on_item():
	$cursor.global_position = $bag/items.get_child(currentTarget).global_position+Vector2(32,32)


func _on_close_btn_pressed():
	hide()
	pass # Replace with function body.


func _on_prev_ptn_pressed() -> void:
	
	#$party.get_child(currentTarget).modulate="#fff"
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
