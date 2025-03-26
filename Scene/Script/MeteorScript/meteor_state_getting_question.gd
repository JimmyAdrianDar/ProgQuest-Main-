class_name MeteorStateGettingQuestion extends EnemyState

@export_category("AI")
@export var meteor : CharacterBody2D
@export var summoning_minion_state : EnemyState

var question_data : Dictionary

func enter() -> void:
	print("MeteorGettingQuestionState")
	meteor.question_data = {
		"question": "What is 2 + 2?",
		"answers": ["3", "4", "5"],
		"correct": "4"
	}

func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	return summoning_minion_state

func physics(_delta : float) -> EnemyState:
	return null
