extends "res://addons/fsmgear/source/FsmState.gd"

var endstate=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func enter(actowner):
	super(actowner)
	actowner.player.hide_controls()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
func exit(actowner):
	super(actowner)
	actowner.player.show_controls()
