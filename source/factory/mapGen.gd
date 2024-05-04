extends Node2D

var locTemp= preload("res://source/elements/location.tscn")
@export var locations:Node2D=null
#generate small map
var startLoc
var startChunk

func gen_linear_map(min=5, max=10):
	#fist define the ssize of the map
	#-1 is start location
	var chunksize = randi()%(max-min)+min-1
	# instance a chunk
	var  chunk=load("res://source/elements/chunk.tscn").instantiate()
	var starChunk=chunk
	var lastLoc=null
	var freeLocs=[]
	
	for i in range(chunksize):
		var loc=locTemp.instantiate()
		if(lastLoc!=null):
			lastLoc.add_conection(loc)
			loc.add_conection(lastLoc)
			freeLocs.push_back(loc)
			
		lastLoc=loc
		
		loc.position=Vector2(0,0-64*i)
		chunk.add_location(loc)
		
	for i in range(2):
		freeLocs.shuffle()
		var loc =  freeLocs.pop_front()
		loc.set_foe()
		
	#END GAME LOCK
	var endloc=locTemp.instantiate()
	endloc.position=lastLoc.position-Vector2(0,64);
	endloc.set_roadend()
	lastLoc.add_conection(endloc)
	endloc.add_conection(lastLoc)
	
	chunk.add_location(endloc)	
	
	startLoc=chunk.mapLocs[0]
	locations.add_child(chunk)
	
	pass
	
