extends CharacterBody2D

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

var health : int = 100

func _ready() -> void:
	healthbar.init_health(health)
	enemy_state_machine.initialize(self)

func take_damage(amount):
	health -= amount
	healthbar.health = health
	print(health)
	if health <= 0:
		queue_free()
	pass

func _process(delta: float) -> void:
	pass
