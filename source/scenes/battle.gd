extends Control

var foeTemp=load("res://source/elements/battle/foe.tscn")
var cmdTemp=load("res://source/elements/battle/command.tscn")
@onready var fsm = $fsm

var onBattle=false

var turn=-1
var PLAYER_TURN=0
var FOE_TURN=1
var party=null

var onTargetSelect = false
var partyActions  =0



var foes

var action_targets=[]

var quickAction=false

# Called when the node enters the scene tree for the first time.
func _ready():
	fsm.autoload(self)
	
	fsm.set_debug_on($stateDebug)
	
	fsm.addStateTransition("await_battle","battle_start",on_battle)	
	fsm.addStateTransition("battle_start","player_turn",next_turn_is_player)
	fsm.addStateTransition("battle_start","foe_turn",next_turn_is_foe)
	
	fsm.addStateTransition("foe_turn","player_turn",next_turn_is_player)
	fsm.addStateTransition("player_turn","foe_turn",next_turn_is_foe)
	
	fsm.addStateTransition("player_turn","target_select",on_target_select)
	
	fsm.addStateTransition("target_select","execute_action",all_selected)
	fsm.addStateTransition("execute_action","foe_turn",next_turn_is_foe)
	
	fsm.addStateTransition("player_turn","execute_action",execute_action_now)
	
	fsm.addStateTransition("foe_turn","battle_end",victory)
	fsm.addStateTransition("player_turn","battle_end",victory)
	
	fsm.addGlobalTransition("await_battle",out_battle)
	fsm.startState()
	pass # Replace with function body.
	
func execute_action_now():
	return quickAction 
func victory():
	var foeDefeated=true
	for foe in $foes.get_children():
		if  foe.lp>=1:
			foeDefeated=false
	return foeDefeated and onBattle
	
func no_action_left():
	return partyActions<=0

func on_target_select():
	return onTargetSelect
	
func out_target_select():
	return onTargetSelect
	
func all_selected():
	return $fsm/target_select.toSelect <= action_targets.size()		
func on_battle():
	return onBattle
	
func out_battle():
	return !onBattle
	
func start_battle():
	$actleft.text="0"
	show()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fsm.fsmUpdate(delta)
	pass
	
func next_turn(nextTurn):
	turn=nextTurn
	
func next_turn_is_player():
	return  turn==PLAYER_TURN
	pass
	
func next_turn_is_foe():
	return  turn== FOE_TURN
	
	
#replace for:
## "load_commands"(load all party commands pre-batte.
## show_partymember_commands
func hide_player_commands():
	$comands.hide()
	
func set_commands():
	$comands.show()
	$comands.get_children().clear()
	var i =0
	#$party/char: replace for active partymember
	for cmd in $party/char.commands:
		var command = cmdTemp.instantiate()
		match cmd:
			"item":
				if($party/char.has_items()):
					command.visible=false
					pass
			_:
				pass
		command.actFunc=char_command.bind(command)
		command.set_char_owner($party/char)
		command.def_as(cmd)
		command.set_battle_room(self)
		command.position.x=i*64
		$comands.add_child(command)
		i+=1
		
func hide_command():
	$comands.hide()
	
func char_command(cmd):
	
	match cmd.action:
		"hit":
			#$fsm/target_select.exitaction = execute_action()
			$fsm/target_select.toSelect=1
			$fsm/execute_action.action = hurt_foe
			$fsm/execute_action.rollcrit = true
			#$fsm/execute_action.exitaction = hurt_foe
			onTargetSelect=true
		_:
			print("cmd:quick action. ",cmd.action)
			quickAction=true
			$fsm/execute_action.action =cmd.execute_quick_action
	partyActions-=1;
	
	pass
	
	
func hurt_foe():
	for at in action_targets:
		at.hurt(1)
		if($critDice.currentValue>=5):
			at.hurt(1+$critDice.currentValue-4)
		else:
			at.hurt(1)
		
	next_turn(FOE_TURN)
	
	
func roll_crit_dice(callback):
	$critDice.endRollCallback=callback
	$critDice.roll()
	$critDice.show()

func set_party(party):
	
	pass
	
func  act_on_foe(foe):
	action_targets.push_back(foe)
	onTargetSelect=false
	partyActions-=1
	
	
	
func gen_single_foe():
	
	print("cfoe gen")
	$foes.get_children().clear()
	for foe in $foes.get_children():
		$foes.remove_child(foe)
		
	foes=[]
	var f = foeTemp.instantiate()
	
	f.selectCallback= act_on_foe.bind(f)
	foes.push_back(f)
	$foes.add_child(f)

func hurt_player(point =1):
	$party/char.hurt(1)
	
func char_start_turn(char=null):
	$party/char.start_turn()
	
func out_of_battle():
	if(visible):
		self.hide()
		onBattle=false
		get_parent().get_parent().out_of_battle()
	
