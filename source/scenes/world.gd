extends Node2D

var player=null
var dicePopup =null
var cursorIndex=0

@onready var fsm=$fsm
@onready var mapGen=$mapGen
@onready var actors = $actors

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	player=load("res://source/elements/char.tscn").instantiate()
	player.world=self

	fsm.autoload(self)
	fsm.addStateTransition("genworld","idle",$fsm/genworld.state_ended)
	fsm.addStateTransition("idle","movechar",player.moving)
	fsm.addStateTransition("movechar","idle",player.still)
	
	fsm.startState()
	pass # Replace with function body.

func _process(delta):
	fsm.fsmUpdate(delta)

func gameover(win=false):
	$top.show()
	$top/popup.show()
	$top/Camera2D.enabled=true
	$top/Camera2D.show()
	
func inspect_loc(loc):
	if(loc.hasFoe):
		player.wait()
		start_random_battle()
		
func set_cursor_on_loc(loc):
	$cursorLoc.global_position=loc.global_position

func start_random_battle():
	player.on_battle()
	$top.show()
	$top/Camera2D.show()
	$top/Camera2D.enabled=true
	$top/battle.show()
	$top/battle.onBattle=true

func scape_roll():
	dicePopup.roll()	
	
func out_of_battle():
	player.add_gold(100)
	$top.hide()
	$top/Camera2D.hide()
	$top/Camera2D.enabled=false
	$top/battle.hide()
	$top/battle.onBattle=false
	player.reacivate()
	player.go_to_next_loc()
		
func _on_main_menu_btn_pressed():
	ScreenTransition.change_scene_to_file("res://source/scenes/main_menu.tscn")
	pass # Replace with function body.
