extends RigidBody2D
	
var resetState = false
const initialPosition = Vector2(512, 320)

func _integrate_forces(state):
	if resetState:
		state.transform = Transform2D(0.0, initialPosition)
		state.linear_velocity = Vector2(0,0)
		state.angular_velocity = 0
		mode = RigidBody2D.MODE_STATIC
		resetState = false
