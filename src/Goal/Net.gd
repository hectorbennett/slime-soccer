extends Area2D

func _on_body_entered(body):
	if body.name == 'Ball':
		var slime = get_tree().get_root().get_node('Game').get_node(get_parent().slime)
		slime.score_goal()
