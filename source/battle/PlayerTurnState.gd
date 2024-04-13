extends "res://addons/fsmgear/source/FsmState.gd"

var endstate=false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func enter(actowner):
	super(actowner)
	actowner.partyActions = 1
	actowner.set_commands()
	pass

func update(actowner,delta):
	pass

func state_ended():
	return endstate;
