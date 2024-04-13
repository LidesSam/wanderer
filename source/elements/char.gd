extends Area2D


var world=null
var currentLoc=null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_current_loc(loc):
	currentLoc=loc
	global_position=currentLoc.global_position
	
func _on_go_btn_pressed():
	pass # Replace with function body.


func _on_move_btn_pressed():
	$Camera2D/controls/inspectBtn.hide()
	$Camera2D/controls.hide()
	if(currentLoc.roadend):
		$Camera2D.enabled=false
		$Camera2D.hide()
		world.gameover(true)
	else:
		$Camera2D/controls.show()
		set_current_loc(currentLoc.conectedLocs[currentLoc.conectedLocs.size()-1]) 
		if (currentLoc.hasEvent):
			$Camera2D/controls/inspectBtn.show()
	pass # Replace with function body.


func _on_inspect_btn_pressed():
	world.inspect_loc(currentLoc)
	pass # Replace with function body.

func wait():
	$Camera2D.enabled=false
	$Camera2D.hide()
	
func reacivate():
	$Camera2D.enabled=true
	$Camera2D.show()
	currentLoc.hasEvent=false
	
