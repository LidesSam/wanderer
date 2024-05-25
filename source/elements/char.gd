extends Area2D


var world=null
var currentLoc=null
@onready var dicePopup=$Camera2D/dicePopup
var party=[]
var gold=0
# Called when the node enters the scene tree for the first time.
func _ready():
	dicePopup=$Camera2D/dicePopup
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_current_loc(loc):
	currentLoc=loc
	global_position=currentLoc.global_position
	world.cursorIndex=0
	world.set_cursor_on_loc(currentLoc.connectedLocs[world.cursorIndex])
	
	
func _on_go_btn_pressed():
	pass # Replace with function body.


func on_battle():
	$Camera2D.enabled=false
	$Camera2D.hide()
	
func _on_move_btn_pressed():
	$Camera2D/controls/inspectBtn.hide()
	$Camera2D/controls.hide()
	
	
	if(currentLoc.roadend):
		$Camera2D.enabled=false
		$Camera2D.hide()
		world.gameover(true)
		return 0
	else:
		$Camera2D/controls.show()
		if (currentLoc.hasEvent):
			$Camera2D/controls/moveBtn.hide()
			$Camera2D/controls/inspectBtn.hide()
			world.scape_roll()
		else:
			go_to_next_loc()
	pass # Replace with function body.

func go_to_next_loc():
	$Camera2D/controls/moveBtn.show()
	set_current_loc(currentLoc.connectedLocs[world.cursorIndex]) 
	if (currentLoc.hasEvent):
		$Camera2D/controls/inspectBtn.show()
		
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

func add_gold(g):
		gold+=g


func _on_menu_btn_pressed():
	$Camera2D/playerMenu.show()
	$Camera2D/playerMenu.update_gold(gold)
	pass # Replace with function body.


func _on_next_loc_btn_pressed():
	world.cursorIndex+=1
	if(world.cursorIndex>=currentLoc.connectedLocs.size()):
		world.cursorIndex=0
	world.set_cursor_on_loc(currentLoc.connectedLocs[world.cursorIndex])
	print("windex:",world.cursorIndex)
	pass # Replace with function body.
