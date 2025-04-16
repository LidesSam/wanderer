extends TextureRect

var currentTarget=0

# Called when the node enters the scene tree for the first time.
func _ready():
	update_cursor_pos_on_party_char()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_gold(gold):
	$header/gold.text= str("GOLD:",gold)
	

func update_cursor_pos_on_party_char():
	$cursor.global_position = $party.get_child(currentTarget).global_position+Vector2(32,32)
	$party.get_child(currentTarget).modulate="#f00"

func _on_close_btn_pressed():
	hide()
	pass # Replace with function body.


func _on_prev_ptn_pressed() -> void:
	
	$party.get_child(currentTarget).modulate="#fff"
	currentTarget-=1
	while   $party.get_child(currentTarget)==null or $party.get_child(currentTarget).wanderclass=="free":
		currentTarget-=1
		if(currentTarget<0):
			currentTarget=0
	update_cursor_pos_on_party_char()


func _on_next_btn_pressed() -> void:
	$party.get_child(currentTarget).modulate="#fff"
	currentTarget+=1
	while  $party.get_child(currentTarget)==null or $party.get_child(currentTarget).wanderclass=="free":
		currentTarget+=1
		if(currentTarget>2):
			currentTarget=0
	update_cursor_pos_on_party_char()
