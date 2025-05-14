extends CharacterBody2D

signal boss_destroyed

@export var question_list : Array[Dictionary] = [
{"question": "Which of the following words is a preposition?", "correct": "On", "options": ["Jump", "On", "Happy"]},
{"question": "Which of the following words is a noun?", "correct": "Happiness", "options": ["Quickly", "Happiness", "Jump"]},
{"question": "Which part of speech describes an action?", "correct": "Verb", "options": ["Noun", "Verb", "Adjective"]},
{"question": "Which part of speech replaces a noun?", "correct": "Pronoun", "options": ["Adjective", "Pronoun", "Verb"]},
{"question": "Which word is an example of a noun?", "correct": "Table", "options": ["Run", "Quickly", "Table"]},
{"question": "Which part of speech expresses strong emotions?", "correct": "Interjection", "options": ["Verb", "Interjection", "Adjective"]}
]

@onready var enemy_state_machine : EnemyStateMachine = $EnemyStateMachine
@onready var healthbar: ProgressBar = $CanvasLayer/Healthbar
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var health : int = 60

func _ready() -> void:
	healthbar.init_health(health)
	enemy_state_machine.initialize(self)

func take_damage(amount):
	health -= amount
	healthbar.health = health

#happens when the boss reaches 0 hp
	if health <= 0:
		emit_signal("boss_destroyed")
	pass

func update_animation(state:String) -> void:
	animation_player.play(state + "_")
	pass

func _process(delta: float) -> void:
	pass
