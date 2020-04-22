extends KinematicBody2D

export var UI_LEFT = "ui_left"
export var UI_RIGHT = "ui_right"
export var UI_UP = "ui_up"
export var UI_DOWN = "ui_down"
export var DIRECTION = "right"
export var INITIAL_TEAM_INDEX = 0

const UP = Vector2(0, -1)
const GRAVITY = 100
const SPEED = 500
const JUMP_HEIGHT = 1500
var motion = Vector2()

var current_team = 0

var score = 0

func set_team(index):
	# If MySprite is a child
	if index >= len(Global.TEAMS):
		index = 0
	elif index < 0:
		index = len(Global.TEAMS) - 1
	get_node("BodyTexture").modulate = Color(Global.TEAMS[index]['body'])
	get_node("DecorationTexture").modulate = Color(Global.TEAMS[index]['decoration'])
	current_team = index
	get_parent().update_team_labels()

func _ready():
	current_team = INITIAL_TEAM_INDEX
	set_team(current_team)
	if DIRECTION == "left":
		get_node("DecorationTexture").set_flip_h(true)
		get_node("EyeTexture").set_position(Vector2(-36, -8))

func _process(_delta):
	_look_at_ball()
	if not Global.gameInProgress:
		if Input.is_action_just_pressed(UI_UP):
			set_team(current_team + 1)
		if Input.is_action_just_pressed(UI_DOWN):
			set_team(current_team - 1)

func _physics_process(_delta):
		
	motion.y += GRAVITY
	
	if Global.gameInProgress:
		if Input.is_action_pressed(UI_RIGHT):
			motion.x = SPEED
		elif Input.is_action_pressed(UI_LEFT):
			motion.x = -SPEED
		else:
			motion.x = 0
	
		if Input.is_action_just_pressed(UI_UP):
			if is_on_floor():
				motion.y = -JUMP_HEIGHT

	motion = move_and_slide(motion, UP)

func _look_at_ball():
	var eye = get_node("EyeTexture")
	eye.look_at(Global.ballNode.position)

func score():
	score += 1
	get_parent().update_team_labels()
	get_parent().reset()
