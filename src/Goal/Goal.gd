extends Node2D

signal score

export(NodePath) var BallPath

onready var BALL = get_node(BallPath)

func _on_Net_body_entered(body: Node) -> void:
	if body == BALL:
		emit_signal("score")
