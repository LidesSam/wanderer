extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	actowner.visible=false
	actowner.turn=-1#avoid trigger of battle
	pass
