class_name MeteorStateLanded extends EnemyState

@export_category("AI")
@export var getting_question_state : EnemyState

func enter() -> void:
	print("MeteorLandedState")

func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	return getting_question_state

func physics(_delta : float) -> EnemyState:
	return null
