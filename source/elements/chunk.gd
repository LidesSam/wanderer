extends Node2D


var mapLocs=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_location(loc):
	
	add_child(loc)
	mapLocs.push_back(loc)
	
	
