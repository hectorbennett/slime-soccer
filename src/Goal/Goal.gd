extends Node2D

export(NodePath) var SlimePath
export(NodePath) var BallPath

onready var SLIME = get_node(SlimePath)
onready var BALL = get_node(BallPath)

func _on_Net_body_entered(body: Node) -> void:
	if body == BALL:
		SLIME.score()
