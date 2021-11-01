extends KinematicBody2D
class_name Slime

signal change_team

const TEAMS = [
	{'name': 'Argentina', 'body': '0AFDFF', 'decoration': 'FFFFFF'},
	{'name': 'Spain', 'body': 'CF0000', 'decoration': '05008B'},
	{'name': 'Italy', 'body': '817CFF', 'decoration': 'FFFFFF'},
	{'name': 'Japan', 'body': '06008B', 'decoration': 'FFFFFF'},
	{'name': 'Senegal', 'body': 'FFFFFF', 'decoration': 'FF7900'},
	{'name': 'South Corea', 'body': 'FF0000', 'decoration': 'FFFFFF'},
	{'name': 'Australia', 'body': '00FF00', 'decoration': 'FFFFFF'},
	{'name': 'P.R. of China', 'body': 'FFFFFF', 'decoration': 'FF0000'},
	{'name': 'Cameroon', 'body': '008700', 'decoration': 'FF0000'},
	{'name': 'Costa Rica', 'body': '8B0000', 'decoration': '05008B'},
	{'name': 'Tunisia', 'body': 'FFFFFF', 'decoration': 'FF0000'},
	{'name': 'Uruguay', 'body': '00B9B6', 'decoration': '000200'},
	{'name': 'Germany', 'body': 'FFFFFF', 'decoration': '010202'},
	{'name': 'Slovenia', 'body': 'FFFFFF', 'decoration': '008400'},
	{'name': 'Sveden', 'body': 'FEF100', 'decoration': '1100FF'},
	{'name': 'England', 'body': 'E6E7E7', 'decoration': 'FF0000'},
	{'name': 'Crotia', 'body': '9A0000', 'decoration': 'FFFFFF'},
	{'name': 'Denmark', 'body': '851E0E', 'decoration': 'FFFFFF'},
	{'name': 'Eucador', 'body': 'FDFF00', 'decoration': '070080'},
	{'name': 'Mexico', 'body': '00FF00', 'decoration': '00FF00'},
	{'name': 'France', 'body': 'FFFFFF', 'decoration': '1200FF'},
	{'name': 'Paraguay', 'body': 'FF0000', 'decoration': 'FFFFFF'},
	{'name': 'Poland', 'body': 'FFFFFF', 'decoration': 'FF0000'},
	{'name': 'Russia', 'body': 'FFFFFF', 'decoration': '1200FF'},
	{'name': 'Portugal', 'body': '7E2405', 'decoration': '008700'},
	{'name': 'Ireland', 'body': '00FF00', 'decoration': 'FFFFFF'},
	{'name': 'Senegal', 'body': 'FFFFFF', 'decoration': 'FF7800'},
	{'name': 'Saudi Arabia', 'body': 'FFFFFF', 'decoration': '28FF70'},
	{'name': 'Seth Efrica', 'body': 'FFFFFF', 'decoration': '27AC4A'},
]

onready var body: Sprite = $BodyTexture
onready var eye: Sprite = $EyeTexture
onready var decoration: Sprite = $DecorationTexture
onready var smile: Sprite = $SmileTexture

export var UI_LEFT := "ui_left"
export var UI_RIGHT := "ui_right"
export var UI_UP := "ui_up"
export var UI_DOWN := "ui_down"
export var DIRECTION := "right"
export var INITIAL_TEAM_INDEX := 0

export(NodePath) var GoalHangingZone

onready var GOAL_HANGING_ZONE = get_node(GoalHangingZone)

const UP := Vector2(0, -1)
const GRAVITY := 100
const SPEED := 500
const JUMP_HEIGHT := 1500

var motion := Vector2()
var current_team_index := 0
var team: Dictionary = TEAMS[INITIAL_TEAM_INDEX]
var score := 0
var frozen := true

func set_team(index: int):
	if index >= len(TEAMS):
		index = 0
	elif index < 0:
		index = len(TEAMS) - 1
	current_team_index = index
	team = TEAMS[index]
	set_sprite_color(body, Color(team['body']))
	set_sprite_color(decoration, Color(team['decoration']))
	GOAL_HANGING_ZONE.set_colour(Color(team['decoration']))
	emit_signal('change_team')
	
func set_sprite_color(texture: Sprite, color: Color):
	texture.modulate = color

func _ready():
	hide_smile()
	current_team_index = INITIAL_TEAM_INDEX
	set_team(current_team_index)
	if DIRECTION == "left":
		decoration.set_flip_h(true)
		eye.set_position(Vector2(-36, -8))

func _process(_delta: float):
	if frozen and not Globals.gameInProgress:
		if Input.is_action_just_pressed(UI_UP):
			set_team(current_team_index + 1)
		if Input.is_action_just_pressed(UI_DOWN):
			set_team(current_team_index - 1)

func _physics_process(_delta: float):
	motion.y += GRAVITY
	if not frozen:
		# move left and right
		if Input.is_action_pressed(UI_RIGHT):
			motion.x = SPEED
		elif Input.is_action_pressed(UI_LEFT):
			motion.x = -SPEED
		else:
			motion.x = 0
		
		# jump
		if Input.is_action_just_pressed(UI_UP):
			if is_on_floor():
				motion.y = -JUMP_HEIGHT
			
	else:
		motion.x = 0
		motion.y = 0
	motion = move_and_slide(motion, UP)

func stare_at(node: RigidBody2D):
	eye.look_at(node.position)

func show_smile():
	smile.show()

func hide_smile():
	if smile:
		smile.hide()
