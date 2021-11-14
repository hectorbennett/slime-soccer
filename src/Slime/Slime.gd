# todo: set direction export to be enum

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

var velocity := Vector2()
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

var is_jumping = false
var is_touching_left_wall = false
var is_touching_right_wall = false
var collision = null

func _physics_process(_delta: float):
	if get_tree().paused:
		velocity.x = 0
		velocity.y = 0
		return

	if is_jumping:
		velocity.y += GRAVITY

	if Input.is_action_pressed(UI_RIGHT):
		if not is_touching_right_wall:
			velocity.x = SPEED
			is_touching_left_wall = false
		else:
			velocity.x = 0
	elif Input.is_action_pressed(UI_LEFT):
		if not is_touching_left_wall:
			velocity.x = -SPEED
			is_touching_right_wall = false
		else:
			velocity.x = 0
	else:
		velocity.x = 0
	
	# jump
	if Input.is_action_just_pressed(UI_UP):
		if not is_jumping:
			velocity.y = -JUMP_HEIGHT
			is_jumping = true

	collision = move_and_collide(velocity * _delta)

	if collision:
		if collision.collider.name == 'Floor':
			is_jumping = false
			velocity = velocity.slide(collision.normal)
		if collision.normal == Vector2(1,0):
			is_touching_left_wall = true
			velocity = velocity.slide(collision.normal)
		if collision.normal == Vector2(-1,0):
			is_touching_right_wall = true
			velocity = velocity.slide(collision.normal)

func stare_at(node: RigidBody2D):
	if node:
		eye.look_at(node.position)

func show_smile():
	smile.show()

func hide_smile():
	if smile:
		smile.hide()
		
func reset() -> void:
	set_position(INITIAL_POSITION)
	velocity.x = 0
	velocity.y = 0	

func _on_Gui_message_completed() -> void:
	reset()

func _on_Game_game_started() -> void:
	reset()
