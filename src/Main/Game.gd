"""
TODO:
	- Add 'click on an option to play' text
	- Add goalhanging
	- Stop ball going through floor
	- Hold ball with down key
	- Make it so you 
"""
extends Node

const initialSlimeLeftPosition = Vector2(256, 448)
const initialSlimeRightPosition = Vector2(768, 448)

var duration = 0
var elapsed = 0
var gameInProgress = false

func _ready():
	reset()
	$HUD.hide_timer()
	$Ball.hide()
	$Ball.set_sleeping(true)
	on_score()

func _process(_delta):
	$SlimeLeft.stare_at($Ball)
	$SlimeRight.stare_at($Ball)

func new_game(d):
	reset()
	duration = d
	elapsed = 0
	gameInProgress = true
	$HUD.hide_splash()
	$HUD.show_timer()
	$GameTimer.start()
	$Ball.show()
	$Ball.set_sleeping(false)
	$SlimeLeft.score = 0
	$SlimeRight.score = 0
	$SlimeLeft.frozen = false
	$SlimeRight.frozen = false
	
func end_game():
	$Ball.set_sleeping(true)
	$GameTimer.stop()
	$HUD.show_splash()
	$HUD.hide_timer()
	$SlimeLeft.frozen = true
	$SlimeRight.frozen = true
	

func on_score():
	$HUD.update_left_label($SlimeLeft.team['name'], $SlimeLeft.score)
	$HUD.update_right_label($SlimeRight.team['name'], $SlimeRight.score)
	if ($SlimeLeft.score > $SlimeRight.score + 3):
		$SlimeLeft.show_smile()
	elif ($SlimeRight.score > $SlimeLeft.score + 3):
		$SlimeRight.show_smile()
	else:
		$SlimeLeft.hide_smile()
		$SlimeRight.hide_smile()
	reset()

func reset():
	$SlimeLeft.set_position(initialSlimeLeftPosition)
	$SlimeRight.set_position(initialSlimeRightPosition)
	$Ball.resetState = true

func _on_click_start_game(_duration):
	new_game(duration)

func _on_GameTimer_timeout():
	elapsed += 1
	$HUD.update_timer(duration - elapsed)
	if (duration - elapsed <= 0):
		end_game()

func _on_SlimeLeft_change_team():
	$GoalHangingIndicatorLeft.set_color($SlimeLeft.team['decoration'])

func _on_GoalBoxLeft_body_entered(body):
	if (body.name == 'SlimeLeft'):
		$GoalHangingIndicatorLeft.start()
	pass # Replace with function body.


func _on_GoalHangingTimerLeft_timeout():
	print('goalhanging!')
	pass # Replace with function body.
