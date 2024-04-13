extends Node2D

var atk=1
var def=1


var lp=10
var maxlp=10
var actionEnd=false
var commands=["hit","def"]#"item"




var items=[]

var onDef=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start__turn():
	onDef=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$lpLabel.text=str(lp,"/",maxlp)
	pass
	
func has_items():
	return items.size()>0
	
func set_on_def():
	onDef=true
	
func set_on_wait():
	pass
	
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
