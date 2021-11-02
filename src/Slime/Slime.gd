extends KinematicBody2D
class_name Slime

signal change_team

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

export var INITIAL_POSITION := Vector2(256, 448)

const UP := Vector2(0, -1)
const GRAVITY := 100
const SPEED := 500
const JUMP_HEIGHT := 1500

var motion := Vector2()
var current_team_index := 0
var team: Dictionary = Globals.teams[INITIAL_TEAM_INDEX]

func set_team(index: int):
	if index >= len(Globals.teams):
		index = 0
	elif index < 0:
		index = len(Globals.teams) - 1
	current_team_index = index
	team = Globals.teams[index]
	set_sprite_color(body, Color(team['body']))
	set_sprite_color(decoration, Color(team['decoration']))
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
	stare_at($"../Ball")
	if get_tree().paused and not Globals.gameInProgress:
		if Input.is_action_just_pressed(UI_UP):
			set_team(current_team_index + 1)
		if Input.is_action_just_pressed(UI_DOWN):
			set_team(current_team_index - 1)

func _physics_process(_delta: float):
	motion.y += GRAVITY
	if not get_tree().paused:
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
	if node:
		eye.look_at(node.position)

func show_smile():
	smile.show()

func hide_smile():
	if smile:
		smile.hide()

func _on_Gui_message_completed() -> void:
	set_position(INITIAL_POSITION)
	motion.x = 0
	motion.y = 0
