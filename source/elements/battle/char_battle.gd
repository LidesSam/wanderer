extends Node2D

var atk=1
var def=1


var lp=10
var maxlp=10
var actionEnd=false
var commands=["hit","def","item"]#

var items=[]

var onDef=false
var criticalDice = load("res://source/elements/components/dice.tscn").instantiate()

var wanderclass="free"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start__turn():
	onDef=false

func define_as(charname="wanderer"):
	wanderclass=charname
	match charname:
		"free":
			$spr.hide()
			$lpLabel.text="FREE"
			
		"wanderer":
			$spr.play("wanderer")
			$spr.show()
			atk=1
			def=1
			lp=10
			maxlp=10
			commands=["hit","def","item"]
			update_life()
			
		"warrior":
			$spr.play("warrior")
			$spr.show()
			atk=2
			def=2
			lp=15
			maxlp=15
			commands=["hit","item"]
			update_life()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_life()
	
func update_life():
	if wanderclass!="free":
		$lpLabel.text=str(lp,"/",maxlp)
	
func has_items():
	return items.size()>0
	
func set_on_def():
	onDef=true
	
func set_on_wait():
	pass
	
func start_turn():
	onDef=false
	
func atk_target(target):
	target.hurt(atk)
	actionEnd=true
			
func hurt(point):
	$AnimSprEffect.play("impact")
	if(onDef):
		point-=def
		if(point<0):
			point=0
	lp-=point
	if(point>0):	
		$AnimEffect.play("lp_shake")
		
func animation_is_running():
	return $AnimEffect.is_playing()
