extends Node

# class_name = Game

const initialSlimeLeftPosition = Vector2(256, 448)
const initialSlimeRightPosition = Vector2(768, 448)

var duration := 0
var elapsed := 0
var gameInProgress := false

onready var GAME_TIMER: Timer = $GameTimer
onready var HUD: HUD = $HUD
onready var BALL: Ball = $Ball
onready var SLIME_LEFT: Slime = $SlimeLeft
onready var SLIME_RIGHT: Slime = $SlimeRight

func _ready():
	reset()
	HUD.hide_timer()
	BALL.hide()
	BALL.set_sleeping(true)
	# on_score()

func _process(_delta):
	SLIME_LEFT.stare_at(BALL)
	SLIME_RIGHT.stare_at(BALL)

func new_game(d):
	reset()
	duration = d
	elapsed = 0
	gameInProgress = true
	HUD.hide_splash()
	HUD.show_timer()
	GAME_TIMER.start()
	BALL.show()
	BALL.set_sleeping(false)
	SLIME_LEFT.score = 0
	SLIME_RIGHT.score = 0
	SLIME_LEFT.frozen = false
	SLIME_RIGHT.frozen = false
	
func end_game():
	BALL.set_sleeping(true)
	GAME_TIMER.stop()
	HUD.show_splash()
	HUD.hide_timer()
	SLIME_LEFT.frozen = true
	SLIME_RIGHT.frozen = true

func on_score():
	HUD.update_left_label(SLIME_LEFT.team['name'], SLIME_LEFT.score)
	HUD.update_right_label(SLIME_RIGHT.team['name'], SLIME_RIGHT.score)
	if (SLIME_LEFT.score > SLIME_RIGHT.score + 3):
		SLIME_LEFT.show_smile()
	elif (SLIME_RIGHT.score > SLIME_LEFT.score + 3):
		SLIME_RIGHT.show_smile()
	else:
		SLIME_LEFT.hide_smile()
		SLIME_RIGHT.hide_smile()
	reset()

func reset():
	SLIME_LEFT.set_position(initialSlimeLeftPosition)
	SLIME_RIGHT.set_position(initialSlimeRightPosition)
	BALL.resetState = true

func _on_click_start_game(d: int):
	new_game(d)

func _on_GameTimer_timeout():
	elapsed += 1
	HUD.update_timer(duration - elapsed)
	if (duration - elapsed <= 0):
		end_game()

func _on_GoalHangingZoneLeft_on_timeout() -> void:
	print('LEFT GOAL HANGING')
	pass # Replace with function body.
