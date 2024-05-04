extends Marker2D


#location.gd
var locType =0

var hasEvent=false
var hasFoe=false



var conectedLocs=[]

var roadend=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_conection(loc):
	conectedLocs.push_back(loc)

func land_in():
	for mapLoc in conectedLocs:
		mapLoc.show_cursor()
		
func set_foe():
	hasEvent=true
	hasFoe=true
		
func show_cursor():
	$cursor.visible=true
	
func set_roadend():
	roadend=true
	$spr.self_modulate ="ff0000"
