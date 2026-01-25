extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.partyScreen.classData.hide()
	actowner.partyScreen.selector.hide()
	
	actowner.partyScreen.equipCursor.show()
	actowner.partyScreen.equipOptions.show()
	actowner.partyScreen.equipData.show()
	actowner.partyScreen.equipCursor.show()
	
	actowner.partyScreen.set_equip_cursor_on_item()

func exit(actowner):
	actowner.partyScreen.classData.show()
	actowner.partyScreen.selector.show()
	
	actowner.partyScreen.equipList.hide()
	actowner.partyScreen.selectingEquip=false
	actowner.partyScreen.equipCursor.hide()
	actowner.partyScreen.equipOptions.hide()
	actowner.partyScreen.equipData.hide()
	actowner.partyScreen.equipCursor.hide()
