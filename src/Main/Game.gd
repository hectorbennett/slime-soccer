extends Node

signal game_started
signal game_ended
signal game_paused
signal game_unpaused

var duration := 0
var elapsed := 0

onready var GUI: Gui = $Gui

func _ready() -> void:
	get_tree().paused = true
	
func _input(event):
	if Input.is_action_pressed("ui_cancel") and Globals.gameInProgress:
		toggle_pause()
		
func toggle_pause():
	if Globals.isPaused and get_tree().paused:
		get_tree().paused = false
		emit_signal("game_unpaused")
		Globals.isPaused = false
	elif not Globals.isPaused and not get_tree().paused:
		get_tree().paused = true
		emit_signal("game_paused")
		Globals.isPaused = true

func new_game(d) -> void:
	get_tree().paused = false
	duration = d
	elapsed = 0
	Globals.left_score = 0
	Globals.right_score = 0
	Globals.gameInProgress = true
	$GameTimer.start()
	emit_signal("game_started")
	
func end_game() -> void:
	emit_signal("game_ended")
	$GameTimer.stop()
	get_tree().paused = true
	
func set_smiles() -> void:
	if Globals.left_score >= Globals.right_score + 3:
		$SlimeLeft.show_smile()
	elif Globals.right_score >= Globals.left_score + 3:
		$SlimeRight.show_smile()
	else:
		$SlimeLeft.hide_smile()
		$SlimeRight.hide_smile()

func _on_Gui_start_game(d: int) -> void:
	new_game(d)

func _on_GameTimer_timeout() -> void:
	elapsed += 1
	GUI.update_timer(duration - elapsed)
	if (duration - elapsed <= 0):
		end_game()

func _on_GoalLeft_scored() -> void:
	Globals.right_score += 1
	
func _on_GoalRight_scored() -> void:
	Globals.left_score += 1

func _on_GoalLeft_goal_hanged() -> void:
	Globals.right_score += 1

func _on_GoalRight_goal_hanged() -> void:
	Globals.left_score += 1

func _on_Gui_message_completed() -> void:
	set_smiles()
