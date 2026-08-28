extends Control

#instance element templates
var charTemp=load("res://source/elements/battle/char_battle.tscn")
var foeTemp=load("res://source/elements/battle/foe.tscn")
var cmdTemp=load("res://source/elements/battle/command.tscn")

@onready var fsm = $fsm

#hold the current turn index
var turn=-1

#turn iterators
var PLAYER_TURN=0
var FOE_TURN=1

#hold the party pointers null mean "free"
var party=[null,null,null]
var activeChar=-1
#flag 
#to entere in target selection
var onTargetSelect = false
#if is on battle 
var onBattle=false

var foes=[]

#used to select a target
var action_targets=[]

var quickAction=false
var submenu=""

#world player ref
var player=null

# Called when the node enters the scene tree for the first time.
func _ready():
	fsm.autoload(self)
	
	fsm.set_debug_on($stateDebug)
	
	fsm.addStateTransition("await_battle","battle_start",on_battle)	
	fsm.addStateTransition("battle_start","player_turn",next_turn_is_player)
	fsm.addStateTransition("battle_start","foe_turn",next_turn_is_foe)
	
	fsm.addStateTransition("foe_turn","player_turn",next_turn_is_player)
	fsm.addStateTransition("player_turn","foe_turn",next_turn_is_foe)
	
	fsm.addStateTransition("player_turn","item_select",on_item_select)

	fsm.addStateTransition("item_select","target_select",on_target_select)
	fsm.addStateTransition("player_turn","target_select",on_target_select)
	
	fsm.addStateTransition("target_select","execute_action",all_selected)
	fsm.addStateTransition("execute_action","foe_turn",next_turn_is_foe)
	fsm.addStateTransition("execute_action","player_turn",$fsm/execute_action.state_ended)
	fsm.addStateTransition("player_turn","execute_action",execute_action_now)
	
	fsm.addStateTransition("foe_turn","battle_end",victory)
	fsm.addStateTransition("player_turn","battle_end",victory)
	
	fsm.addGlobalTransition("await_battle",out_battle)
	fsm.startState()
	
func start_battle():
	$actleft.text="0"
	show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fsm.fsmUpdate(delta)
	$TurnLbl/at.text=str("Act:",activeChar)

#fsm conditions
func execute_action_now():
	return quickAction 

func victory():
	var foeDefeated=true
	var animation_ended=true
	for foe in $foes.get_children():
		if  foe.lp>=1:
			foeDefeated=false
		if foe.animation_is_running():
			animation_ended=false
	return animation_ended and foeDefeated and onBattle
	
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

func on_item_select():
	return submenu=="item"
	
func next_turn_is_player():
	return  turn==PLAYER_TURN
	
func next_turn_is_foe():
	var animation_ended=true
	for foe in $foes.get_children():
		if foe.animation_is_running():
			animation_ended=false
	return animation_ended  and turn== FOE_TURN
	

func next_turn(nextTurn):
		turn=nextTurn	
#replace for:
## "load_commands"(load all party commands pre-batte.
## show_partymember_commands
func hide_player_commands():
	$comands.hide()
	
func set_commands():
	for cmd in $comands.get_children():
		$comands.remove_child(cmd)
	$comands.show()
	var i =0
	
	for cmd in party[activeChar].commands:
		var command = cmdTemp.instantiate()
		command.actFunc=char_command.bind(command)
		command.set_char_owner(party[activeChar])
		#party[0].modulate="#ff0000"
		print("setCommand:",cmd)
		if cmd=="weapon":
			var weapon=party[0].equiped["weapon"]
			print("setCommand:",weapon)
			if weapon!=null:
				print("setCommand:",weapon.attack_type)
				match weapon.attack_type:
					weapon.AttackType.HIT:
						command.def_as("hit")
					weapon.AttackType.SLASH:
						command.def_as("slash")
					weapon.AttackType.MAGIC:
						command.def_as("magic")
					_:
						command.def_as("hit")
			else:
				command.def_as("hit")
		else:
			command.def_as(cmd)
		if cmd=="item":
			if player.has_items():
				command.disabled=false
			else:
				command.disabled=true
		command.set_battle_room(self)
		command.position.x=i*128
		$comands.add_child(command)
		i+=1
		
func set_commands_submenu():
	
	for cmd in $comands.get_children():
		$comands.remove_child(cmd)
	$comands.show()
	
	var i =0
	for cmd in player.bag["items"]:
		var command = cmdTemp.instantiate()
		command.actFunc=char_command.bind(command)
		command.set_char_owner(party[0])
		command.def_as_item(cmd.itemName,cmd)
		command.set_battle_room(self)
		command.position.x=i*64
		$comands.add_child(command)
		i+=1
	
func char_command(cmd):
	#DEFAULT SELEC MODE
	$fsm/target_select.targetScope=$fsm/target_select.FOE_SCOPE
	$fsm/target_select.targetSelectMode=$fsm/target_select.MANUAL_SELECT
	
	match cmd.action:
		"hit":
			$fsm/target_select.toSelect=1
			$fsm/execute_action.action = hurt_foe
			$fsm/execute_action.rollcrit = true
			onTargetSelect=true
		"slash":
			$fsm/target_select.toSelect=1
			$fsm/execute_action.action = hurt_foe
			$fsm/execute_action.rollcrit = true
			onTargetSelect=true
		"magic":
			$fsm/target_select.toSelect=1
			$fsm/execute_action.action = hurt_foe
			$fsm/execute_action.rollcrit = true
			onTargetSelect=true
		"heal":
			$fsm/target_select.toSelect=1
			$fsm/target_select.targetScope=$fsm/target_select.PARTY_SCOPE
			$fsm/execute_action.action = heal_target
			$fsm/execute_action.rollcrit = false
			onTargetSelect=true
		"item":
			submenu="item"
		"bomb":
			#$fsm/target_select.exitaction = execute_action()
			$fsm/target_select.toSelect=1
			$fsm/target_select.targetSelectMode=$fsm/target_select.AUTO_SELECT_ALL
			$fsm/execute_action.action = hurt_foe
			$fsm/execute_action.rollcrit = false
			#$fsm/execute_action.exitaction = hurt_foe
			onTargetSelect=true
		"soda":
			#$fsm/target_select.exitaction = execute_action()
			$fsm/target_select.toSelect=1
			$fsm/target_select.targetScope=$fsm/target_select.PARTY_SCOPE
			$fsm/target_select.targetSelectMode=$fsm/target_select.AUTO_SELECT_ALL
			$fsm/execute_action.action = heal_target.bind(1)
			$fsm/execute_action.rollcrit = false
			#$fsm/execute_action.exitaction = hurt_foe
			onTargetSelect=true
		"thunder":
			#$fsm/target_select.exitaction = execute_action()
			$fsm/target_select.toSelect=randi()%3+1
			$fsm/target_select.targetSelectMode=$fsm/target_select.AUTO_RANDOM_SELECT
			$fsm/execute_action.action = atk_spell_on_foe.bind("thunder",1, 3)
			$fsm/execute_action.rollcrit = false
			#$fsm/execute_action.exitaction = hurt_foe
			onTargetSelect=true
		"fire":
			#$fsm/target_select.exitaction = execute_action()
			$fsm/target_select.toSelect=1
			$fsm/target_select.targetSelectMode=$fsm/target_select.AUTO_RANDOM_SELECT
			$fsm/execute_action.action = atk_spell_on_foe.bind("fire",1, 3)
			$fsm/execute_action.rollcrit = false
			#$fsm/execute_action.exitaction = hurt_foe
			onTargetSelect=true
		"ice":
			#$fsm/target_select.exitaction = execute_action()
			$fsm/target_select.toSelect=1
			$fsm/target_select.targetSelectMode=$fsm/target_select.AUTO_RANDOM_SELECT
			$fsm/execute_action.action = atk_spell_on_foe.bind("ice",1, 3)
			$fsm/execute_action.rollcrit = false
			#$fsm/execute_action.exitaction = hurt_foe
			onTargetSelect=true
		_:
			print("cmd:quick action. ",cmd.action)
			quickAction=true
			$fsm/execute_action.action =cmd.execute_quick_action
		
	#if is an item
	if cmd.item!=null:
		#reduce item used 
		player.item_was_used(cmd.item)
		#
		set_commands_submenu()


	

func heal_target():
	for at in action_targets:
		at.heal(1)
	if(activeChar+1>3):
		next_turn(FOE_TURN)
	else:
		$fsm/execute_action.endstate=true
	
func hurt_foe():
	for at in action_targets:
		at.hurt(1)
		if($critDice.currentValue>=5):
			at.hurt(party[activeChar-1].get_atk()+$critDice.currentValue-4)
		else:
			at.hurt(party[activeChar-1].get_atk())
	if(activeChar+1>3):
		next_turn(FOE_TURN)
	else:
		$fsm/execute_action.endstate=true
	
func atk_spell_on_foe(atrib="none",base=1, modifier=1):
	var dmg=0
	for at in action_targets:
		at.hurt(base*modifier)
		match atrib:
			"none":
				dmg= base + modifier
			"thunder": 
				dmg= 1+randi()%(base+modifier)*0.5
			"fire":
				dmg=  base *randi()%modifier*0.5
			"ice":
				dmg= base + modifier*0.5
		at.hurt(round(dmg),atrib)
	
	if(activeChar+1>3):
		next_turn(FOE_TURN)
	else:
		$fsm/execute_action.endstate=true

func roll_crit_dice(callback):
	$critDice.endRollCallback=callback
	$critDice.roll()
	$critDice.show()

func set_party(cparty):
	for c in $party.get_children():
		$party.remove_child(c)
	
	var i =0
	
	for pchar in cparty.get_children() :
		var charTemp = charTemp.instantiate()
		
		if(pchar.wanderclass!="free"):
			party[i]=charTemp
			party[i].global_position.x+=i*64
			party[i].define_as(pchar.wanderclass)
			party[i].lp = pchar.lp
			party[i].maxlp = pchar.maxlp
			party[i].equiped=pchar.equiped
			$party.add_child(charTemp)
			party[i].selectCallback= act_on_target.bind(party[i])
		else:
			party[i]=null
		i+=1
	pass
func set_player(p):
	player=p
	set_party(player.party)
	
func  act_on_target(target):
	action_targets.push_back(target)
	onTargetSelect=false
	
func gen_single_foe():
	$foes.get_children().clear()
	for foe in $foes.get_children():
		$foes.remove_child(foe)
		
	foes=[]
	var r = randi()%3+1
	r=3
	for i in range(r):

		var f = foeTemp.instantiate()
		f.position.x= i *96
		f.set_rand_foe()
		f.selectCallback= act_on_target.bind(f)
		foes.push_back(f)
		$foes.add_child(f)

func hurt_player(dmp =1, anim="impact"):
	var targets = []
	var i=0
	for target in party:
		if(party[i]!=null):
			if(target.can_be_targeted()):
					targets.push_back(i) 
		i+=1
	print("hurt-p:",anim)
	var t = targets.pick_random()
	party[t].hurt(dmp,anim)
	
func char_start_turn(char=null):
	party[activeChar].start_turn()
	
func out_of_battle():
	if(visible):
		self.hide()
		onBattle=false
		get_parent().get_parent().out_of_battle()
	
