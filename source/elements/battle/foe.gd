extends Node2D


var atk=0
var lp=3
var maxlp=3
var actionEnd=false
var selectCallback
var foename="slime"

# Called when the node enters the scene tree for the first time.
func _ready():
	update_lp()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func  update_lp():
	$lpLabel.text=str(lp,"/",maxlp)
	
func set_rand_foe():
	var r=randi()%6
	print("rfope:",r)
	
	match (r):
		1, 2: #33.5 
			foename="board"
			$spr.play("board")
			maxlp=4
			atk=2
			print("board")
		3:#16.5
			
			foename="eye"
			$spr.play("eye")
			maxlp=3
			atk=3
			print("eye")
		_:#50%
			
			foename="slime"
			$spr.play("slime")
			maxlp=3
			atk=1
			print("slime")
		
	lp=maxlp
	update_lp()
	
func atk_target(target):
	print("foe atk(",atk,")")
	target.hurt(atk)
	actionEnd=true
			
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
	
func hurt(points):
	$AnimEffect.play("impact")
	lp-=points
	print("hurt lp left:",lp)
	
	if(lp<=0):
		lp=0
		$spr.play(str(foename,"-die"))
	update_lp()


func _on_select_pressed():
	$select.hide()
	selectCallback.call()
	pass # Replace with function body.

func animation_is_running():
	if(lp<=0):
		return $AnimEffect.is_playing()  and $spr.is_playing()
	else:
		return $AnimEffect.is_playing()
