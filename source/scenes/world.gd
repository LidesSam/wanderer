extends Node2D

var player=null
var dicePopup =null

# Called when the node enters the scene tree for the first time.
func _ready():
	player=load("res://source/elements/char.tscn").instantiate()


	$gen.gen_linear_map(5,10)
	player.set_current_loc($gen.startLoc)
	
	$actors.add_child(player)
	player.world=self
	
	dicePopup = player.dicePopup 
	dicePopup.goodResult=player.go_to_next_loc
	dicePopup.badResult=start_random_battle
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func gameover(win=false):
	$top.show()
	$top/popup.show()
	$top/Camera2D.enabled=true
	$top/Camera2D.show()
	
func inspect_loc(loc):
	if(loc.hasFoe):
		player.wait()
		start_random_battle()
		
func start_random_battle():
	$top.show()
	$top/Camera2D.show()
	$top/Camera2D.enabled=true
	$top/battle.show()
	$top/battle.onBattle=true

func scape_roll():
	dicePopup.roll()	
	
func out_of_battle():
	$top.hide()
	$top/Camera2D.hide()
	$top/Camera2D.enabled=false
	$top/battle.hide()
	$top/battle.onBattle=false
	player.reacivate()
		
func _on_main_menu_btn_pressed():
	ScreenTransition.change_scene_to_file("res://source/scenes/main_menu.tscn")
	pass # Replace with function body.
