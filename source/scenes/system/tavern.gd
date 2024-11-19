extends Node2D

@export var outCallback: Callable
@export var optiontemp = preload("res://source/elements/components/buyoption.tscn")
var buyer=null
# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Ensure the menu is hidden initially
	$Camera2D.enabled = false
	$Camera2D.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Method to show the menu and enable the camera
func go_in():
	show()
	$Camera2D.enabled = true
	$Camera2D.show()
	gen_choices()
	if buyer:
		$gold.text=str("G",buyer.gold)

# Method to generate dynamic options
func gen_choices():
	var options = $choices
	# Clear existing children safely
	for op in options.get_children():
		op.queue_free()

	# Generate a random number of choices between 1 and 3
	var num_choices = randi() % 3 + 1
	for i in range(num_choices):
		# Create a new instance of the option scene
		var op = optiontemp.instantiate()
		op.define_as_random_option()
		op.position = Vector2(i * 80, 0)
		options.add_child(op)

# Method to handle the exit button press
func _on_exit_btn_pressed():
	$Camera2D.enabled = false
	$Camera2D.hide()
	hide()
	
	# Check if the callback is valid and call it if so
	if outCallback and outCallback.is_valid():
		outCallback.call()
