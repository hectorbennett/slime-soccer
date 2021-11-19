extends RigidBody2D
class_name Ball

var resetState := false
var positionAboveSlime := false
const initialPosition := Vector2(512, 320)

const floor_pos = 490

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
    if resetState:
        set_mode(RigidBody2D.MODE_STATIC)
        state.transform = Transform2D(0.0, initialPosition)
        state.linear_velocity = Vector2(0,0)
        state.angular_velocity = 0
        resetState = false

    if positionAboveSlime:
        call_deferred("position_above_slime", state)

    if global_position.y > floor_pos:
        print('whoops')
        # call_deferred("position_above_slime", state)

func position_above_slime(state: Physics2DDirectBodyState) -> void:
    set_mode(RigidBody2D.MODE_KINEMATIC)
    global_position = global_position - Vector2(0, 80)
    # state.transform = Transform2D(0.0, initialPosition)
    state.linear_velocity = Vector2(0, 0)
    state.angular_velocity = 0
    call_deferred("set_mode", RigidBody2D.MODE_RIGID)
    positionAboveSlime = false

func reset() -> void:
    resetState = true
    call_deferred("set_mode", RigidBody2D.MODE_RIGID)

func _on_Game_game_inited() -> void:
    hide()

func _on_Game_game_started() -> void:
    show()
    reset()

func _on_Gui_message_completed() -> void:
    reset()
