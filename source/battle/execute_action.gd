extends "res://addons/fsmgear/source/FsmState.gd"

var action=null
var endstate= false
var rollcrit = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func enter(actowner):
	endstate=false
	super(actowner)
	actowner.get_node("counterLbl").text=str(actowner.action_targets.size())
	
	active_next_char_or_finalize(actowner)
	if(actowner.quickAction):
		actowner.quickAction=false

				
		if(actowner.activeChar>2):
			actowner.activeChar=0
			actowner.next_turn(actowner.FOE_TURN)
		else:
			endstate=true
		actowner.hide_player_commands()
		action.call()
	else:
		if(rollcrit):
			print("exe")
			actowner.roll_crit_dice(trigger_action.bind(actowner))
		else:
			action.call()
	rollcrit = false
func active_next_char_or_finalize(actowner):
	print("act i:",actowner.activeChar)
	if(actowner.activeChar==0):
		if actowner.party[1]!=null:
			actowner.activeChar=1
		elif actowner.party[2]!=null:
			actowner.activeChar=2
		else:
			actowner.activeChar=3
	elif actowner.activeChar==1:
		if actowner.party[2]!=null:
			actowner.activeChar=2
		else:
			actowner.activeChar=3
	elif actowner.activeChar==2:
		actowner.activeChar=3
	else:
		actowner.activeChar=3
	print("act f:",actowner.activeChar)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
func state_ended():
	return endstate
func trigger_action(actowner):
	actowner.get_node("critDice").hide()
	action.call()
func exit(actowner):
	if actowner.activeChar>2:
		actowner.activeChar=0
	super(actowner)
