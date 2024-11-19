extends Node2D

# Variables to store the cost, operation action, and operation name
var cost = 20
var opact = "none"
var opname = "none"

# Simulate player money (you can replace this with your actual game's player money system)
var player_money = 200

# Called when the node enters the scene tree for the first time
func _ready():
	update_ui()

# Updates the cost label, button text, and name label
func update_ui():
	if $costlbl:
		$costlbl.text = str(cost)
	if $buybtn:
		$buybtn.text = opact
	if $namelbl:
		$namelbl.text = opname

# Define as a random option with random cost, action, and name
func define_as_random_option():
	match randi() % 3:
		0:define_as_hire()
		1:define_as_item()
		2:define_as_service()

# Define this item as something that can be hired
func define_as_hire():
	opact = "hire"
	opname = "wanderer"
	cost = 100
	update_ui()

# Define this item as something that can be bought
func define_as_item():
	opact = "buy"
	opname = "potion"
	cost = 20
	update_ui()

# Define this item as a service to be required
func define_as_service():
	opact = "require"
	opname = "restore"
	cost = 50
	update_ui()

# Called when the buy button is pressed
func _on_buybtn_pressed():
	print("Attempting to:", opact, opname, "with cost:", cost)
	if can_afford(cost):
		handle_purchase()
	else:
		print("Not enough funds to", opact)

# Function to check if the player can afford the cost
func can_afford(amount: int) -> bool:
	return player_money >= amount

# Function to handle the purchase logic
func handle_purchase():
	print(opact, opname, "completed successfully!")
	# Deduct the cost from the player's money
	player_money -= cost
	print("Remaining funds:", player_money)
	# Optional: Provide feedback to the player (e.g., show a message or update UI)
	update_ui()
