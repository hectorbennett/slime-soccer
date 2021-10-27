# https://youtu.be/JRvQrmuzmO8?t=149

extends Node2D

signal on_timeout

export(NodePath) var SlimePath

onready var SLIME = get_node(SlimePath)
onready var TIMER: Timer = $Timer
onready var PROGRESS_BAR: ProgressBar = $ProgressBar2
onready var PB_STYLEBOX = PROGRESS_BAR.get("custom_styles/fg")

func _ready() -> void:
	pass
	# print(PB_STYLEBOX)
	# PB_STYLEBOX.bg_color = Color('ffffff')

func _on_Area2D_body_entered(body: Node) -> void:
	if body == SLIME:
		TIMER.start()
		
func _on_Area2D_body_exited(body: Node) -> void:
	if body == SLIME:
		TIMER.stop()
		PROGRESS_BAR.value = 100

func _on_Timer_timeout() -> void:
	PROGRESS_BAR.value -= 1
	if PROGRESS_BAR.value <= 0:
		emit_signal("on_timeout")
		TIMER.stop()
		
func set_colour(colour: Color) -> void:
	# print('set colour')
	# print(colour)
	print(colour)
	if PB_STYLEBOX:
		# PB_STYLEBOX.add_stylebox_override('bg_color', colour)
		PB_STYLEBOX.bg_color = colour
