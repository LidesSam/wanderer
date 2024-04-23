extends Button

var battleRoom
var charOwner
var action
var actFunc:Callable
var quickFunc:Callable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func def_as(action_type="hit"):
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
	
func set_battle_room(battleroom):
	battleRoom=battleroom
	
func set_char_owner(charowner):
	charOwner=charowner
	
func execute_quick_action():
	match action:
		"def":
			charOwner.set_on_def()
			pass
		"wait":
			charOwner.set_on_wait()
			pass


func _on_pressed():
	actFunc.call()
