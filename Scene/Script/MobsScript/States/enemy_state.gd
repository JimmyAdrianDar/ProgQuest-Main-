class_name EnemyState extends Node

#-----Reference to the enemy that use this state machine------
var enemy : LavaSlime
var state_machine : EnemyStateMachine

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
