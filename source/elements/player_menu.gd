extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_gold(gold):
	$header/gold.text= str("GOLD:",gold)
	



func _on_close_btn_pressed():
	hide()
	pass # Replace with function body.
