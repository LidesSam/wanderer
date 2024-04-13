extends "res://addons/fsmgear/source/FsmState.gd"

var endstate=false
var timer=null
# Called when the node enters the scene tree for the first time.
func _ready():
	timer=Timer.new()
	timer.wait_time=3
	timer.connect("timeout",timer_timeout)
	add_child(timer)
	timer.one_shot=true
	pass # Replace with function body.


func enter(actowner):
	endstate=false
	super(actowner)
	timer.start()
	#actowner.turn = actowner.PLAYER_TURN
	pass

func update(actowner,delta):
	pass

func state_ended():
	return endstate;
	
func timer_timeout():
	parentFsm.actowner.hurt_player()
	parentFsm.actowner.turn= parentFsm.actowner.PLAYER_TURN
	endstate=true
	pass
