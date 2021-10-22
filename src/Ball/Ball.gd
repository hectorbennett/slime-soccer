extends RigidBody2D
class_name Ball
	
var resetState := false
const initialPosition := Vector2(512, 320)


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if resetState:
		reset(state)

func reset(state: Physics2DDirectBodyState) -> void:
	state.transform = Transform2D(0.0, initialPosition)
	state.linear_velocity = Vector2(0,0)
	state.angular_velocity = 0
	set_mode(RigidBody2D.MODE_STATIC)
	resetState = false
