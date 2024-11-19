extends Area2D


var world=null
var currentLoc=null
@onready var dicePopup=$Camera2D/dicePopup
@onready var party=$Camera2D/playerMenu/party
var visitedLocs=[]
var gold=0
var onMove=false
var moveSpeed=50
# Called when the node enters the scene tree for the first time.
func _ready():
	dicePopup=$Camera2D/dicePopup
	party.get_node("lchar").define_as("wanderer")
	party.get_node("mchar").define_as("warrior")
	party.get_node("rchar").define_as("free")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(onMove):
		var velocity = global_position.direction_to(currentLoc.global_position) * 50
		if global_position.distance_to(currentLoc.global_position) > 1:
			position+=velocity*delta
		else:
			global_position = currentLoc.global_position
			onMove=false
	pass
	
func moving():
	return onMove
	 
func still():
	return !onMove 
	
func set_current_loc(loc):
	currentLoc=loc
	
	if(currentLoc.roadend):
		$Camera2D.enabled=false
		$Camera2D.hide()
		world.gameover(true)
		return 0
	else:
		onMove=true
		world.cursorIndex=0
		if(visitedLocs.size()==0):
			world.set_cursor_on_loc(currentLoc.connectedLocs[0])
		else:
			search_and_set_next_loc()
			world.set_cursor_on_loc(currentLoc.connectedLocs[world.cursorIndex])
		visitedLocs.push_back(loc)
	currentLoc=loc


func on_battle():
	$Camera2D.enabled=false
	$Camera2D.hide()
	
func _on_move_btn_pressed():
	$Camera2D/controls/inspectBtn.hide()
	$Camera2D/controls.hide()
	$Camera2D/controls.show()
	if (currentLoc.hasEvent):
		$Camera2D/controls/moveBtn.hide()
		$Camera2D/controls/inspectBtn.hide()
		world.scape_roll()
	else:
		go_to_next_loc()
func hide_controls():
	$Camera2D/controls.hide()
func show_controls():
	$Camera2D/controls.show()
	
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
	search_and_set_next_loc()
	world.set_cursor_on_loc(currentLoc.connectedLocs[world.cursorIndex])
	print("windex:",world.cursorIndex)
	pass # Replace with function body.
	
func search_and_set_next_loc():
	world.cursorIndex+=1
	if(world.cursorIndex>=currentLoc.connectedLocs.size()):
		world.cursorIndex=0
	while(visitedLocs.has(currentLoc.connectedLocs[world.cursorIndex])):
		world.cursorIndex+=1
		if(world.cursorIndex>=currentLoc.connectedLocs.size()):
			world.cursorIndex=0
