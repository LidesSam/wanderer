extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.bagScreen.show()
	actowner.partyScreen.hide()
	actowner.bagScreen.display_item_data()
