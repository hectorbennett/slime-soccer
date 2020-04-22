extends RichTextLabel


# Declare member variables here. Examples:
var ms = 0;
var s = 0;
var m = 2;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_old(delta):
	if ms > 9:
		s += 1
		ms = 0
		
	if s > 59:
		m += 1
		s = 0
	
	var M = '%0*d' % [2, m]
	var S = '%0*d' % [2, s]
	var MS = '%0*d' % [2, ms]

	set_text('{m} : {s} : {ms}'.format({'m': M, 's': S, 'ms': MS}))

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
	pass # Replace with function body.
