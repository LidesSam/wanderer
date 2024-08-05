extends Node2D

# Preload the location scene
var locTemp = preload("res://source/elements/location.tscn")
@export var locations: Node2D = null  # Node to hold all generated locations

# Variables for map generation
var startLoc  # Starting location of the map
var startChunk  # Starting chunk of the map
var step = 64  # Step distance between locations
@onready var chunkTemp = load("res://source/elements/chunk.tscn")  # Load the chunk scene

var starChunk = null  # Variable to store the first chunk
var maxChunks = 4  # Maximum number of chunks
var chunks = []  # List to store all chunks

# Function to generate a linear map
func gen_linear_map(min=5, max=10):
	# Define the size of the first chunk
	var chunksize = randi() % (max - min) + min
	var lastLoc = null  # Last location to connect new locations to

	# Generate chunks and connect locations
	for i in range(maxChunks):
		lastLoc = gen_chunk(chunksize, lastLoc)
		chunksize = randi() % (max - min) + min

	# Create the end location and connect it to the last location
	var endloc = locTemp.instantiate()
	endloc.position = lastLoc.position - Vector2(0, step)
	endloc.set_roadend()
	lastLoc.add_conection(endloc)
	endloc.add_conection(lastLoc)
	chunks[-1].add_location(endloc)  # Add the end location to the last chunk
	startLoc = chunks[0].mapLocs[0]  # Set the start location to the first chunk's first location

	pass

# Function to generate a chunk with a specified number of locations
func gen_chunk(chunksize, lastLoc):
	var stepOffset = Vector2(0, 0)
	if lastLoc:
		stepOffset = lastLoc.position + Vector2(0, -64)  # Offset for the new chunk based on last location's position
	
	var chunk = chunkTemp.instantiate()  # Instance a new chunk
	if not starChunk:
		starChunk = chunk  # Set the first chunk
	
	# Generate locations within the chunk
	for i in range(chunksize):
		var loc = locTemp.instantiate()
		if lastLoc != null:
			lastLoc.add_conection(loc)
			loc.add_conection(lastLoc)
		lastLoc = loc
		
		loc.position = Vector2(0, 0 - step * i) + stepOffset  # Position the location
		chunk.add_location(loc)  # Add the location to the chunk
	
	chunk.add_sidepath_sub_bifurcation(locTemp, step, 5)  # Add side paths
	chunk.add_rand_foe_encounters(2, 4)  # Add random foe encounters
	chunks.push_back(chunk)  # Add the chunk to the chunks list
	locations.add_child(chunk)  # Add the chunk to the locations node
	
	return lastLoc  # Return the last location for connecting further locations
	pass
