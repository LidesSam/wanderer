extends Node2D
#chunk.gd

var mapLocs=[]
var freeLocs=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_location(loc):
	add_child(loc)
	mapLocs.push_back(loc)
	if(mapLocs.size()>1):
		freeLocs.push_back(loc)
	
func add_rand_foe_encounters( min:int=1, max:int=2):
	if(max<=min):
		max= min+1
	var r = randi()%floor(max-min)+min
	for i in range(r):
		freeLocs.shuffle()
		var loc =  freeLocs.pop_front()
		loc.set_foe()
