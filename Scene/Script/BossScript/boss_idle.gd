class_name BossStateIdle extends EnemyState

@export_category("AI")
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5
@export var after_idle_state : EnemyState

var _timer : float = 0.0
var _wait_time : float = 0.0

func init() -> void:
	pass

func enter() -> void:
	_wait_time = randf_range(state_duration_min, state_duration_max)
	_timer = 0.0
	pass

func exit() -> void:
	pass

func process (_delta : float) -> EnemyState:
	_timer += _delta
	if _timer >= _wait_time:
		return after_idle_state
	return null

func physics(_delta : float) -> EnemyState:
	return null
