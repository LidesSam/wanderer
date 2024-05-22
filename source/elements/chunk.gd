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

##gen a small bifurcation inside of the chunk
func add_sidepath_sub_bifurcation(locTemp,step:int = 64,size:int=3):
	
	if(mapLocs.size()<3):
		print("to small to bifurcation")
		return false
		
	if(size>mapLocs.size()-2):
		size=mapLocs.size()-2
	var lastLoc=mapLocs[0]
	var displazament= Vector2(step,0)
	for i in range(size):
		var pos= 1+i
		var loc=locTemp.instantiate()
		lastLoc.add_conection(loc)
		loc.add_conection(lastLoc)
		add_location(loc)
		loc.position=mapLocs[pos].position+displazament
		lastLoc=loc
	lastLoc.add_conection(mapLocs[size+1])
	
func add_rand_foe_encounters( min:int=1, max:int=2):
	if(max<=min):
		max= min+1
	var r = randi()%floor(max-min)+min
	for i in range(r):
		freeLocs.shuffle()
		var loc =  freeLocs.pop_front()
		loc.set_foe()
