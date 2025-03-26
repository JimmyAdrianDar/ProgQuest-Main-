class_name MeteorStateSummoningMinion extends EnemyState

signal minion_spawned(minions : Array)

@export_category("AI")
@export var meteor : CharacterBody2D

var minions : Array = []

func enter() -> void:
	print("MeteorGettingQuestionState")
	if "answers" in meteor.question_data:
		for answer in meteor.question_data["answers"]:
			var minion_scene = preload("res://Scene/Scene/BossScene/minions.tscn")  # Load the scene
			var minion = minion_scene.instantiate()
			minion.answer_text = answer
			meteor.get_parent().add_child(minion)
			minions.append(minion)
	
	emit_signal("minion_spawned", minions)

func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	return null

func physics(_delta : float) -> EnemyState:
	return null
