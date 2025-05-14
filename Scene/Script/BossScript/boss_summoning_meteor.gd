class_name BossStateQuestion extends EnemyState

@export_category("AI")
@export var boss: CharacterBody2D
@export var minion_scene: PackedScene
@export var damage_state: EnemyState

var transition_to_damage: bool = false
var transition_back_to_question: bool = false

var current_question = {}
var minion_positions = [Vector2(-100, 50), Vector2(0, 50), Vector2(100, 50)]
var waiting_for_answer: bool = true

var minions: Array = []

var incorrect_questions: Array = []
var asked_questions: Array = []

var in_review_mode: bool = false  # <== NEW FLAG

func enter() -> void:
	print("Boss Question State")
	waiting_for_answer = true
	await cleanup_minions()
	ask_question()

func exit() -> void:
	cleanup_minions()

func ask_question():
	var available_questions = []
	
	if !in_review_mode:
		# Normal round: ask unasked questions
		available_questions = boss.question_list.filter(func(q): return q not in asked_questions)

		if available_questions.is_empty():
			if incorrect_questions.is_empty():
				print("All questions answered correctly. Quiz done.")
				# End or change state as needed
				return
			else:
				in_review_mode = true
				ask_question()  # Call again now in review mode
				return
	else:
		# Review mode: ask uncorrected wrong questions
		available_questions = incorrect_questions

		if available_questions.is_empty():
			print("All incorrect questions corrected. Ending question phase.")
			# All incorrect questions corrected now
			# Change to damage state or next boss phase
			transition_to_damage = true
			return

	current_question = available_questions.pick_random()
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
		minions.append(minion)

func _on_minion_died(minion):
	if minion.is_correct:
		boss.take_damage(15)
		
		# ✅ Mark current question as asked
		if current_question not in asked_questions:
			asked_questions.append(current_question)

		# ✅ Remove from incorrect if it was wrong before
		if current_question in incorrect_questions:
			incorrect_questions.erase(current_question)
		
		await cleanup_minions()
		await get_tree().create_timer(0.5).timeout
		if boss.health <= 0:
			return
		ask_question()
	else:
		if current_question not in asked_questions:
			asked_questions.append(current_question)

		if current_question not in incorrect_questions:
			incorrect_questions.append(current_question)

		await cleanup_minions()
		await get_tree().create_timer(0.5).timeout
		transition_to_damage = true

func cleanup_minions():
	for minion in minions:
		if is_instance_valid(minion):
			minion.queue_free()
	minions.clear()
	await get_tree().process_frame

func process(_delta: float) -> EnemyState:
	if transition_to_damage:
		transition_to_damage = false
		return damage_state
	return null
