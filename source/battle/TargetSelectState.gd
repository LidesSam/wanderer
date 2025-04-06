extends "res://addons/fsmgear/source/FsmState.gd"

var endstate=false
var toSelect= 1

var targetSelectMode=0

static var MANUAL_SELECT=0
static var AUTO_RANDOM_SELECT=1
static var AUTO_SELECT_ALL=2

var targetScope=0

static var FOE_SCOPE=0
static var PARTY_SCOPE=1
static var ALL_SCOPE=2
static var NO_SCOPE=3


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func enter(actowner):
	super(actowner)
	actowner.hide_player_commands()
	actowner.action_targets=[]
	match targetSelectMode:
		MANUAL_SELECT:
			#enable selection of foes so the player manually select the targets
			match targetScope:
				PARTY_SCOPE:
					for char in actowner.party:
						if(char):
							char.selection_mode()
				FOE_SCOPE:
					for foe in actowner.foes:
						foe.selection_mode()
				ALL_SCOPE:
					for char in actowner.party:
						if(char):
							char.selection_mode()
					for foe in actowner.foes:
						foe.selection_mode()
		AUTO_RANDOM_SELECT:
			#enable selection of foes so the player manually select the targets
			var i =0
			while(i<toSelect):
				i+=1
				var foe=actowner.foes.pick_random()
				foe.selectCallback.call()
			pass
		AUTO_SELECT_ALL:
			#enable selection of foes so the player manually select the targets
			for foe in actowner.foes:
				foe.selectCallback.call()
			
	# enaable seleectioon


func update(actowner,delta):
	actowner.get_node("counterLbl").text=str(actowner.action_targets.size(),"/",toSelect)

func state_ended():
	return endstate;
	
func exit(actowner):
	actowner.get_node("counterLbl").text=str(actowner.action_targets.size(),"/",toSelect)
