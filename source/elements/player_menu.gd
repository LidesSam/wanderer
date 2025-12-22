extends TextureRect

var currentTarget=0
var currentTab="party"
var currentTabMode="state"
var currentSlot=0
var state = "state"

@onready var fsm =$fsm

@onready var bagScreen= $bag
@onready var partyScreen= $party



# Called when the node enters the scene tree for the first time.
func _ready():
	fsm.autoload(self)
	fsm.addStateTransition("bagState","partState",dummy)
	fsm.addStateTransition("partState","bagState",dummy)
	fsm.startState()
#	update_cursor_pos_on_party_char()
#	gen_display_items()
	
func dummy():
	return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fsm.fsmUpdate(delta)

func update_gold(gold):
	$header/gold.text= str("GOLD:",gold)

#func update_cursor_pos_on_party_char():
#	var charSelected= $partyScreen.get_child(currentTarget)
#	cursor.global_position = charSelected.global_position+Vector2(32,32)
#	match currentTabMode:
		#"state":
#			$sideData/classData.set_char(charSelected)
		#	pass
		#"equip-and-item":
		#	pass
		#"actions":
		#	pass
			
#mover to bag screen
func gen_display_items():
	var items= get_parent().get_parent().bag
	var i =0
	for item in items:
		var ditem = Label.new()
		ditem.text=item
		$bag/items.add_child(ditem)
		ditem.position= Vector2(i*64,16)
		i+=1	
	
func _on_close_btn_pressed():
	hide()
	pass # Replace with function body.

func _on_party_btn_pressed() -> void:
	bagScreen.hide()
	partyScreen.show()
	
func _on_bagbtn_pressed() -> void:
	bagScreen.show()
	partyScreen.hide()

func _on_equipbtn_pressed() -> void:
	$sideData/classData.hide()
	$sideData/equip.show()
	$cursor/spr.show()
	currentTab="equip"

func _on_statebtn_pressed() -> void:
	$sideData/classData.show()
	$sideData/equip.hide()
	currentTab="state"

#submenu navigation.
func _on_prev_ptn_pressed() -> void:
	currentTarget-=1
	match currentTab:
		"party":
			while  $partyScreen.get_child(currentTarget)==null or $partyScreen.get_child(currentTarget).wanderclass=="free":
				currentTarget-=1
				if(currentTarget<0):
					currentTarget=0
#			update_cursor_pos_on_party_char()
		"bag":
			pass

func _on_next_btn_pressed() -> void:
	#$partyScreen.get_child(currentTarget).modulate="#fff"
	currentTarget+=1
	match currentTab:
		"party":
			while  $partyScreen.get_child(currentTarget)==null or $partyScreen.get_child(currentTarget).wanderclass=="free":
				currentTarget+=1
				if(currentTarget>2):
					currentTarget=0
#			update_cursor_pos_on_party_char()
		
		"bag":
			pass		
