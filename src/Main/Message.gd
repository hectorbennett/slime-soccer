extends RichTextLabel

func display_message(message: String) -> void:
	self.text = message
	get_tree().get_root().get_node("Game").freeze_game()
	yield(get_tree().create_timer(2.0), "timeout")
	self.text = ""
	get_tree().get_root().get_node("Game").unfreeze_game()
