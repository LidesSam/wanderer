extends TextureRect

var currentTarget=0
var currentTab="party"
var currentTabMode="state"
var currentSlot=0
var state = 0

static var PARTYSTATE=0
static var BAGSTATE=1

@onready var fsm =$fsm

@onready var bagScreen= $bag
@onready var partyScreen= $party



func _ready():
	fsm.set_debug_on($Label)
	fsm.autoload(self)
	fsm.addStateTransition("bagState","partyState",is_party_state)
	fsm.addStateTransition("partyState","bagState",is_bag_state)
	fsm.startState()


func is_party_state():
	return state==PARTYSTATE
	
func is_bag_state():
	return state==BAGSTATE
	
func _process(delta):
	fsm.fsmUpdate(delta)

func update_gold(gold):
	$header/gold.text= str("GOLD:",gold)
			
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

func _on_party_btn_pressed() -> void:
	state=PARTYSTATE
	
func _on_bagbtn_pressed() -> void:
	state=BAGSTATE
