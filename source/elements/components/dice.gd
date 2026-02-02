extends Node2D

var onRoll=false
var minValue=1
var maxValue=6
var rollRange=6
var currentValue=0

@export var endRollCallback:Callable 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(onRoll):
		currentValue=randi()%maxValue+minValue
		$Label.text=str(currentValue)
	
func set_dice_range(MinValue=1,MaxValue=6):
	minValue=MinValue
	maxValue=MaxValue
	rollRange=maxValue-minValue+1
	
func stop():
	onRoll=false
	$Timer.stop()
	$AnimationPlayer.play("critical")
	
func roll():
	onRoll=true
	$Timer.start()
	
func autoroll():
	roll()
	$Timer.wait_time=randi()%3+3
	

func _on_timer_timeout():
	print("timeOut")
	stop()
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	if(endRollCallback):
		endRollCallback.call()
	$AnimationPlayer.play("reset")
