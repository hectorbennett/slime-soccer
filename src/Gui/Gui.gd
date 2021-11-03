extends Control
class_name Gui

signal start_game(duration)
signal message_completed

func _ready() -> void:
	hide_timer()

func update_left_label():
	var team_name = $"../SlimeLeft".team['name']
	var score = Globals.left_score
	$LeftTeamLabel.text = '%s : %s' % [team_name, score]
	
func update_right_label():
	var team_name = $"../SlimeRight".team['name']
	var score = Globals.right_score
	$RightTeamLabel.text = '%s : %s' % [team_name, score]
	
func update_left_goal_hanging_progress_bar():
	pass

func show_splash():
	$Splash.show()

func hide_splash():
	$Splash.hide()
	
func show_timer():
	$TimerLabel.show();

func hide_timer():
	$TimerLabel.hide();

func update_timer(ticks: int):
	# todo: use fmod
	var ms = ticks % 10
	var s = (ticks / 10) % 60
	var m = ticks / 600

	var M = '%0*d' % [2, m]
	var S = '%0*d' % [2, s]
	var MS = '%0*d' % [2, ms]

	$TimerLabel.set_text('{m}:{s}:{ms}'.format({'m': M, 's': S, 'ms': MS}))

func display_message(message: String) -> void:
	get_tree().paused = true
	$Message.bbcode_text = '[center]{message}[/center]'.format({'message': message})
	yield(get_tree().create_timer(2.0), "timeout")
	$Message.text = ""
	get_tree().paused = false
	emit_signal("message_completed")

func _on_1Min_button_up():
	emit_signal('start_game', 600)

func _on_2Min_button_down():
	emit_signal('start_game', 1200)

func _on_4Min_button_up():
	emit_signal('start_game', 2400)

func _on_8Min_button_up():
	emit_signal('start_game', 4800)

func _on_SlimeLeft_change_team() -> void:
	update_left_goal_hanging_progress_bar()
	update_left_label()

func _on_SlimeRight_change_team() -> void:
	update_right_label()

func _on_GoalLeft_scored() -> void:
	# if a goal is scored in the left goal
	var team_name = $"../SlimeRight".team['name']
	display_message('{team_name} scores!\nClick mouse for replay...'.format({'team_name': team_name}))
	update_right_label()

func _on_GoalRight_scored() -> void:
	# if a goal is scored in the right goal
	var team_name = $"../SlimeLeft".team['name']
	display_message('{team_name} scores!\nClick mouse for replay...'.format({'team_name': team_name}))
	update_left_label()
	
func _on_GoalLeft_goal_hanged() -> void:
	var team_name = $"../SlimeLeft".team['name']
	display_message('{team_name} goal hanged!\nClick mouse for replay...'.format({'team_name': team_name}))
	update_right_label()
	
func _on_GoalRight_goal_hanged() -> void:
	var team_name = $"../SlimeRight".team['name']
	display_message('{team_name} goal hanged!\nClick mouse for replay...'.format({'team_name': team_name}))
	update_right_label()

func _on_Game_game_started() -> void:
	hide_splash()
	show_timer()

func _on_Game_game_ended() -> void:
	show_splash()
	hide_timer()
	
func _on_GoalLeft_goal_hanging_value_changed(value) -> void:
	$LeftGoalHangingProgressBar.value = value

func _on_GoalRight_goal_hanging_value_changed(value) -> void:
	$RightGoalHangingProgressBar.value = value



