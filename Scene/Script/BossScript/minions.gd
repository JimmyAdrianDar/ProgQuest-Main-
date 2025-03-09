extends CharacterBody2D

@onready var healthbar: ProgressBar = $Healthbar
@onready var health_component: Node2D = $HealthComponent
@onready var stat_component: Node2D = $StatComponent
@onready var hitbox_component: hitbox = $HitboxComponent

@export var answer_text: String
var is_correct: bool = false
signal died

func _ready():
	healthbar.init_health(health_component.check_health())
	$AnswerLabel.text = answer_text

func _on_death():
	died.emit()
	queue_free()  # Remove minion when killed


func _on_hitbox_component_receive_damage(damage: int) -> void:
	healthbar.health = health_component.reduce_health(damage)

func _on_health_component_died() -> void:
	died.emit()
	queue_free()
	print("BossDied")
