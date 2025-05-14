class_name BossStateDamage extends EnemyState

@onready var anim_name : String = "fireball"

@onready var boss_fight_scene = get_tree().get_root().get_node("/root/BossFight")
@onready var projectile = load("res://Scene/Scene/Projectile/boss_fireball_projectile.tscn")

@export_category("AI")
@export var boss: CharacterBody2D
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5
@export var question_state : EnemyState

var finished : bool = false

func init() -> void:
	pass

func enter() -> void:
	print("BossDealDamageState")
	boss.update_animation(anim_name)
	await get_tree().create_timer(1.3).timeout
	shoot()
	
	boss.animation_player.animation_finished.connect(_on_animation_finished)
	pass

func exit() -> void:
	pass

func _on_animation_finished( _a : String ) -> void:
	finished = true

func shoot() -> void:
	var instance = projectile.instantiate()
	instance.spawnPos = boss.global_position + Vector2(4.0, 3.0)
	boss_fight_scene.add_child.call_deferred(instance)

func process (_delta : float) -> EnemyState:
	if finished:
		finished = false
		return question_state
	
	return null

func physics(_delta : float) -> EnemyState:
	return null
