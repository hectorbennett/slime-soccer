extends Button

export var duration = 1

func _on_button_up():
	get_node('/root/Game').start_game(duration)

