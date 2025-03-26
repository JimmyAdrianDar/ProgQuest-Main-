class_name BossStateDeath extends EnemyState

@export_category("AI")
@export var boss : CharacterBody2D

func enter() -> void:
	print("BossTakingDamageState")
	boss.queue_free()

func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	return null

func physics(_delta : float) -> EnemyState:
	return null
