extends Node

signal score_changed
signal game_started
signal game_ended

var duration := 0
var elapsed := 0

onready var GUI: Gui = $Gui

func _ready() -> void:
	get_tree().paused = true

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
