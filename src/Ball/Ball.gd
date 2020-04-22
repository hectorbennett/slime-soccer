extends RigidBody2D
	
var resetState = false
	
func _integrate_forces(state):
	if resetState:
		state.transform = Transform2D(0.0, Global.initialBallPosition)
		state.linear_velocity = Vector2(0,0)
		state.angular_velocity = 0
		resetState = false
