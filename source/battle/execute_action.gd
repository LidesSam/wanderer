extends "res://addons/fsmgear/source/FsmState.gd"

var action=null
var endstate= false
var rollcrit = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func enter(actowner):
	super(actowner)
	actowner.get_node("counterLbl").text=str(actowner.action_targets.size())
	endstate=true
	if(actowner.quickAction):
		actowner.quickAction=false
		actowner.next_turn(actowner.FOE_TURN)
		actowner.hide_player_commands()
		action.call()
	else:
		if(rollcrit):
			print("exe")
			actowner.roll_crit_dice(trigger_action.bind(actowner))
		else:
			action.call()
	rollcrit = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
func state_ended():
	return endstate
func trigger_action(actowner):
	actowner.get_node("critDice").hide()
	action.call()
	
