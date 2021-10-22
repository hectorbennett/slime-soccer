extends Node2D

onready var styleBox := StyleBoxFlat.new()

onready var TIMER: Timer = $Timer
onready var PROGRESS_BAR: ProgressBar = $ProgressBar

func _ready():
	set_color('#bada55')
	TIMER.start()

func set_color(color: String):
	pass

func start():
	TIMER.start()

func _on_timeout():
	styleBox.bg_color = Color('#bada55')
	PROGRESS_BAR.add_stylebox_override('fg', styleBox)
	PROGRESS_BAR.value -= 1
