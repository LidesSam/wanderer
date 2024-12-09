extends "res://addons/fsmgear/source/FsmState.gd"

var endstate=false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func enter(actowner):
	super(actowner)
	actowner.set_commands()
	actowner.char_start_turn()
	actowner.party[actowner.activeChar].get_node("selected").show()
	pass

func update(actowner,delta):
	pass

func state_ended():
	return endstate;
func exit(actowner):
	actowner.party[actowner.activeChar].get_node("selected").hide()
	super(actowner)
