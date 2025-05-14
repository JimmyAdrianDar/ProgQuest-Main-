class_name BossStateDeath extends EnemyState

@onready var anim_name : String = "death"

@export_category("AI")
@export var boss : CharacterBody2D
@onready var question_label: Label = $"../../QuestionLabel"

func init() -> void:
	boss.boss_destroyed.connect(_on_boss_destroyed)

#Does whenever it enters death state
func enter() -> void:
	question_label.queue_free()
	boss.update_animation(anim_name)
	
	boss.animation_player.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	pass

func _on_boss_destroyed():
	state_machine.change_state(self)
	pass

func _on_animation_finished( _a : String ) -> void:
	boss.queue_free()

func process(_delta : float) -> EnemyState:
	return null

func physics(_delta : float) -> EnemyState:
	return null
