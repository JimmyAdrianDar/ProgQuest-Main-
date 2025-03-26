class_name BossStateDamage extends EnemyState

@export_category("AI")
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5
@export var idle_state : EnemyState

var _timer : float = 0.0

func init() -> void:
	pass

func enter() -> void:
	print("BossDamageState")
	#boss.take_damage(10)
	pass

func exit() -> void:
	pass

func process (_delta : float) -> EnemyState:
	return idle_state

func physics(_delta : float) -> EnemyState:
	return null
