class_name MinionStateAttack extends EnemyState

@export_category("AI")
@export var min_state_timer : float = 5.0
@export var max_state_timer : float = 10.0

func init() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func process (_delta : float) -> EnemyState:
	return null

func physics(_delta : float) -> EnemyState:
	return null
