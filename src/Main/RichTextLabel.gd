extends RichTextLabel

# Declare member variables here. Examples:
var ms = 0;
var s = 0;
var m = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func start(minutes):
	m = minutes
	get_node("Duration").start()

func _process(delta):
	if ms < 0:
		s -= 1
		ms = 9
		
	if s < 0:
		m -= 1
		s = 59
	
	var M = '%0*d' % [2, m]
	var S = '%0*d' % [2, s]
	var MS = '%0*d' % [2, ms]

	set_text('{m} : {s} : {ms}'.format({'m': M, 's': S, 'ms': MS}))

func _on_timeout():
	ms -= 1
