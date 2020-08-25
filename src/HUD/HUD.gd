extends Control

signal start_game(duration)

func update_left_label(team_name, score):
	$LeftTeamLabel.text = '%s : %s' % [team_name, score]
	
func update_right_label(team_name, score):
	$RightTeamLabel.text = '%s : %s' % [score, team_name]

func show_splash():
	$Splash.show()

func hide_splash():
	$Splash.hide()
	
func show_timer():
	$TimerLabel.show();

func hide_timer():
	$TimerLabel.hide();

func show_game_over():
	pass
	
func update_timer(ticks):
	var ms = (ticks % 10)
	var s = (ticks / 10) % 60
	var m = ticks / 600
	
	var M = '%0*d' % [2, m]
	var S = '%0*d' % [2, s]
	var MS = '%0*d' % [2, ms]

	$TimerLabel.set_text('{m}:{s}:{ms}'.format({'m': M, 's': S, 'ms': MS}))

func _on_1Min_button_up():
	emit_signal('start_game', 600)

func _on_2Min_button_down():
	emit_signal('start_game', 1200)

func _on_4Min_button_up():
	emit_signal('start_game', 2400)

func _on_8Min_button_up():
	emit_signal('start_game', 4800)
