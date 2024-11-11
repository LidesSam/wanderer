extends Node2D

@export var outCallback:Callable
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func go_in():
	show()
	$Camera2D.enabled=true
	$Camera2D.show()
	gen_choices()
func gen_choices():
	var store=$choices
func _on_exit_btn_pressed():
	$Camera2D.enabled=false
	$Camera2D.hide()
	hide()
	if(outCallback):
		outCallback.call()
	pass # Replace with function body.
