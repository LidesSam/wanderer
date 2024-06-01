extends "res://addons/fsmgear/source/FsmState.gd"

var endstate=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func enter(actowner):
	super(actowner)

	actowner.mapGen.gen_linear_map(5,10)
	actowner.player.set_current_loc(actowner.mapGen.startLoc)
	actowner.actors.add_child(actowner.player)
	actowner.dicePopup = actowner.player.dicePopup 
	actowner.dicePopup.goodResult=actowner.player.go_to_next_loc
	actowner.dicePopup.badResult=actowner.start_random_battle
	endstate=true

func state_ended():
	return  endstate
