extends Node2D

var atk=1
var def=1


var lp=10
var maxlp=10
var actionEnd=false
var commands=["hit","def","item"]#

var items=["potion","bomb","SODA"]
# Equipped items
var equipped := {
	"weapon": null,  # Should be an EquipableItem
	"armor": null    # Should be an EquipableItem
}

var onDef=false
var criticalDice = load("res://source/elements/components/dice.tscn").instantiate()

var wanderclass="free"

var selectCallback

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
			$spr.show()
			atk=1
			def=1
			lp=10
			maxlp=10
			commands=["hit","def","item"]
			update_life()
			
		"warrior":
			$spr.show()
			atk=2
			def=3
			lp=15
			maxlp=15
			commands=["hit","item"]
			update_life()
		"healer":
			
			$spr.show()
			atk=1
			def=1
			lp=8
			maxlp=8
			commands=["heal","def","item"]
			update_life()
			
		"mage":
			$spr.play("warrior")
			$spr.show()
			atk=1
			def=1
			lp=8
			maxlp=8
			commands=["hit","thunder","item"]
			update_life()
	$spr.play(charname)
	
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

func get_atk():
	if equipped["weapon"]!=null:
		return atk+equipped["weapon"].atk
	return atk
	
func get_def():
	if equipped["armor"]!=null:
		return def + equipped["armor"].def
	return def
	
func start_turn():
	onDef=false
	
func atk_target(target):
	target.hurt(get_atk())
	actionEnd=true

func heal(points):
	lp+=points
	if lp>maxlp:
		lp=maxlp
	$AnimSprEffect.play("sparkling")
					
func hurt(point, anim:String = "impact"):
	$AnimSprEffect.show()
	$AnimSprEffect.play(anim)
	if(onDef):
		point-=get_def()
		if(point<0):
			point=0
	lp-=point
	if(point>0):	
		$AnimEffect.play("lp_shake")
		
func animation_is_running():
	return $AnimSprEffect.is_playing()
	
func can_be_targeted():
	return wanderclass!="free" and lp>0
	
func selection_mode(lpcon=0):
	match lpcon:
		0:#select to healt
			if(lp>0):
				$select.show()
		1:#for revive
			if(lp<0):
				$select.show()
		2:
			$select.show()
func selection_off():
	$select.hide()
	

func _on_select_pressed():
	$select.hide()
	selectCallback.call()
	
