class_name MeteorStateDescend extends EnemyState

@export_category("AI")
@export var land_state : EnemyState
@export var speed : float = 200.0
@export var meteor : CharacterBody2D

var target_position : Vector2

func set_spawn_position(position: Vector2) -> void:
	target_position = position

func enter() -> void:
	print("MeteorDescendState")
	meteor.velocity = (target_position - meteor.global_position).normalized() * speed

func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	return null

func physics(_delta : float) -> EnemyState:
	meteor.move_and_slide()
	if meteor.global_position.distance_to(target_position) < 5:
		return land_state
	return null
