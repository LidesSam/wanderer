extends "res://addons/fsmgear/source/FsmState.gd"

var endstate=false
var toSelect= 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func enter(actowner):
	super(actowner)
	actowner.hide_player_commands()
	actowner.action_targets=[]
	for foe in actowner.foes:
		foe.selection_mode()
	# enaable seleectioon


func update(actowner,delta):
	actowner.get_node("counterLbl").text=str(actowner.action_targets.size(),"/",toSelect)

func state_ended():
	return endstate;
func exit(actowner):
	actowner.get_node("counterLbl").text=str(actowner.action_targets.size(),"/",toSelect)
