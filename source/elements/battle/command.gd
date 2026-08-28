extends Button

var battleRoom
var charOwner
var action
var actFunc:Callable
var quickFunc:Callable
var item = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func def_as(action_type="hit"):
	item=null
	match action_type:
		"hit":
			pass
		"cut":
			pass
		"item":
			pass
		"def":
			pass
		"wait":
			pass
	action= action_type;
	text=action_type

func def_as_item(action_type="potion", itemOnBag=null):
	action= action_type;
	match action_type:
		"potion":
			action= "heal";
		"bomb":
			action= "bomb";
		"soda":
			action= "heal";	
	text=action_type
	item=itemOnBag
	
func heal():
	pass
	
func damage():
	pass
	
func set_battle_room(battleroom):
	battleRoom=battleroom
	
func set_char_owner(charowner):
	charOwner=charowner
	
func execute_quick_action():
	match action:
		"def":
			charOwner.set_on_def()
		"wait":
			charOwner.set_on_wait()

func _on_pressed():
	actFunc.call()
		
		
