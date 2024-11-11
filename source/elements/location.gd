extends Marker2D


#location.gd
var locType =0

var hasEvent=false
var hasFoe=false


var connectedLocs=[]

#indicate the end of the game
var roadend=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_conection(loc):
	connectedLocs.push_back(loc)

func land_in():
	pass
			
func set_foe():
	hasEvent=true
	hasFoe=true
	$type.text="foe"
	$type.show()
	
func set_as_tavern():
	hasEvent=true	
	$type.text="tavern"
	$type.show()
	
func show_cursor():
	$cursor.visible=true
	
func set_roadend():
	roadend=true
	$spr.self_modulate ="ff0000"
