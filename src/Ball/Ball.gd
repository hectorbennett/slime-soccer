extends RigidBody2D
class_name Ball
	
var resetState := false
const initialPosition := Vector2(512, 320)


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if resetState:
		set_mode(RigidBody2D.MODE_STATIC)
		state.transform = Transform2D(0.0, initialPosition)
		state.linear_velocity = Vector2(0,0)
		state.angular_velocity = 0
		resetState = false

func reset() -> void:
	resetState = true
	set_mode(RigidBody2D.MODE_RIGID)
	
func _on_Game_game_inited() -> void:
	hide()

func _on_Game_game_started() -> void:
	show()
	reset()

func _on_Gui_message_completed() -> void:
	reset()
