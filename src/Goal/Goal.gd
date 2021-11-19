extends Node2D

signal scored
signal goal_hanged
signal goal_hanging_value_changed(value)

export(NodePath) var SlimePath

onready var SLIME = get_node(SlimePath)
onready var GOAL_HANGING_TIMER: Timer = $GoalHangingTimer

func _ready() -> void:
    SLIME.set_team(SLIME.current_team_index)

func _process(delta):
    if get_tree().paused or $GoalHangingTimer.is_stopped():
        return

    var value = $GoalHangingTimer.time_left * 100 / $GoalHangingTimer.wait_time
    emit_signal("goal_hanging_value_changed", floor(value))

func _on_Net_body_entered(body: Node) -> void:
    if body == $"../Ball":
        emit_signal("scored")
        $GoalHangingTimer.stop()

func _on_GoalHangingArea_body_entered(body: Node) -> void:
    if body == SLIME:
        $GoalHangingTimer.start()

func _on_GoalHangingArea_body_exited(body: Node) -> void:
    if body == SLIME:
        $GoalHangingTimer.stop()
        emit_signal("goal_hanging_value_changed", 100)

func _on_GoalHangingTimer_timeout() -> void:
    emit_signal("goal_hanged")
