extends Node2D

onready var styleBox = StyleBoxFlat.new()

func _ready():
	set_color('#bada55')
	$Timer.start()

func set_color(color):
	pass

func start():
	$Timer.start()

func _on_timeout():
	styleBox.bg_color = Color('#bada55')
	$ProgressBar.add_stylebox_override('fg', styleBox)
	$ProgressBar.value -= 1
