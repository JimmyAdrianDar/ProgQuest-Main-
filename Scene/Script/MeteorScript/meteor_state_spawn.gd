class_name MeteorStateSpawn extends EnemyState

@export_category("AI")
@export var descend_meteor_state : EnemyState
@export var meteor : CharacterBody2D

var target_position : Vector2

func set_spawn_position(position: Vector2) -> void:
	target_position = position

func enter() -> void:
	print("MeteorSpawnState")
	meteor.global_position = target_position + Vector2(100, 100)

func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	return descend_meteor_state

func physics(_delta : float) -> EnemyState:
	meteor.move_and_slide()
	return null
