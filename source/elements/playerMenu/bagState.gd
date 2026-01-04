extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.bagScreen.show()
	actowner.partyScreen.hide()
