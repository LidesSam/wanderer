extends ColorRect

@onready var dice=$dice

@export var goodResult:Callable
@export var badResult:Callable

# Called when the node enters the scene tree for the first time.
func _ready():
	dice.endRollCallback=coin_end_roll
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func roll():
	show()
	dice.autoroll()

func coin_end_roll():
	hide()
	if (dice.currentValue>floor(dice.maxValue/2)):
		if(goodResult):
			goodResult.call()
	else:
		if(badResult):
			badResult.call()
