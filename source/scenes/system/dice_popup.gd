extends ColorRect

@onready var dice=$dice

@export var goodResult:Callable
@export var badResult:Callable
@export var goodMsg = "Run!"
@export var badMsg = "Encounter!♠!"

# Called when the node enters the scene tree for the first time.
func _ready():
	dice.endRollCallback=coin_end_roll
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func roll():
	show()
	$closeBtn.hide()
	dice.autoroll()

func coin_end_roll():
	$closeBtn.show()
	if (dice.currentValue>floor(dice.maxValue/2)):
		$closeBtn.text =goodMsg
	else:
		$closeBtn.text =badMsg
		

func _on_close_btn_pressed():
	hide()
	if (dice.currentValue>floor(dice.maxValue/2)):
		if(goodResult):
			goodResult.call()
	else:
		if(badResult):
			badResult.call()
	pass # Replace with function body.
