extends Node2D

export var slime = ''

func _ready():
	Global.slimeLeftNode = get_node('SlimeLeft')
	Global.slimeRightNode = get_node('SlimeRight')
	Global.ballNode = get_node('Ball')
	reset()
	Global.ballNode.set_sleeping(true)
	update_team_labels()

func start_game(duration):
	Global.gameInProgress = true
	Global.ballNode.set_sleeping(false)
	get_node("UI/Splash").visible = false
	print('start game')


func update_team_labels():
	print('update team labels')
	if not (Global.slimeLeftNode and Global.slimeRightNode):
		return

	var leftTeamName = Global.TEAMS[Global.slimeLeftNode.current_team]['name']
	var rightTeamName = Global.TEAMS[Global.slimeRightNode.current_team]['name']
	
	var leftScore = Global.slimeLeftNode.score
	var rightScore = Global.slimeRightNode.score
	
	get_node("UI/LeftLabel").text = leftTeamName + ' : ' + str(leftScore)
	get_node("UI/RightLabel").text = str(rightScore) + ' : ' + rightTeamName

func reset():
	Global.slimeLeftNode.set_position(Global.initialSlimeLeftPosition)
	Global.slimeRightNode.set_position(Global.initialSlimeRightPosition)
	Global.ballNode.resetState = true
