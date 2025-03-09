class_name BossStateQuestion extends EnemyState

@export_category("AI")
@export var boss: CharacterBody2D  # Assign the boss node in the editor
@export var minion_scene: PackedScene  # Assign `Minion.tscn`
@export var damage_state: EnemyState 

var current_question = {}
var minion_positions = [Vector2(-100, 50), Vector2(0, 50), Vector2(100, 50)]
var waiting_for_answer: bool = true

var _timer : float = 0.0

var minions: Array = []  # Track spawned minions

func enter() -> void:
	print("Boss Question State")
	waiting_for_answer = true  # Reset state
	await cleanup_minions()  # Ensure minions are cleared before continuing
	ask_question()

func exit() -> void:
	cleanup_minions()  # Ensure all minions are removed when leaving

func ask_question():
	var question_list = boss.question_list
	current_question = question_list.pick_random()
	boss.get_node("QuestionLabel").text = current_question["question"]
	summon_minions()

func summon_minions():
	var answers = current_question["options"].duplicate()
	answers.shuffle()
	
	for i in range(answers.size()):
		var minion = minion_scene.instantiate()
		minion.position = boss.position + minion_positions[i]
		minion.answer_text = answers[i]
		minion.is_correct = (answers[i] == current_question["correct"])
		minion.died.connect(_on_minion_died.bind(minion))
		boss.get_parent().add_child(minion)
		minions.append(minion)  # Store minions in list

func _on_minion_died(minion):
	if minion.is_correct:
		boss.take_damage(10)
		waiting_for_answer = false  # Move to damage state
		await cleanup_minions()  # Wait for all minions to be removed

func cleanup_minions():
	for minion in minions:
		if is_instance_valid(minion):  # Check if minion exists before deleting
			minion.queue_free()
	minions.clear()
	await get_tree().process_frame  # Ensure all minions are removed properly

func process(_delta: float) -> EnemyState:
	if not waiting_for_answer:
		return damage_state
	return null
