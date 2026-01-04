extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.bagScreen.hide()
	actowner.partyScreen.show()
	actowner.partyScreen.cursor.show()
	actowner.partyScreen.set_cursor_on_char()
