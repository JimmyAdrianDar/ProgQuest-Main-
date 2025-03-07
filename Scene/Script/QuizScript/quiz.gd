extends Control

#-----Labels------
@onready var QuestionLabel: Label = $Label
@onready var Choice1Label: Label = $PanelContainer/VBoxContainer/HBoxContainer/Option1/Choices1
@onready var Choice2Label: Label = $PanelContainer/VBoxContainer/HBoxContainer/Option2/Choices2
@onready var Choice3Label: Label = $PanelContainer/VBoxContainer/HBoxContainer2/Option3/Choices3
@onready var Choice4Label: Label = $PanelContainer/VBoxContainer/HBoxContainer2/Option4/Choices4
@onready var result_label: Label = $result

#-----Buttons-----
@onready var ButtonOption1: Button = $PanelContainer/VBoxContainer/HBoxContainer/Option1
@onready var ButtonOption2: Button = $PanelContainer/VBoxContainer/HBoxContainer/Option2
@onready var ButtonOption3: Button = $PanelContainer/VBoxContainer/HBoxContainer2/Option3
@onready var ButtonOption4: Button = $PanelContainer/VBoxContainer/HBoxContainer2/Option4
@onready var try_again_button: Button = $TryAgain
@onready var exit_button: Button = $Exit

#-----Misc-----
@onready var texture_rect: TextureRect = $TextureRect
@onready var tryagaintexture: TextureRect = $tryagaintexture
@onready var panel_container: PanelContainer = $PanelContainer
@onready var complete_texture: TextureRect = $Complete

var questions : Array = []
var current_question_index = 0
var correct_answers : String = ""

func _ready() -> void:
	load_json_data()
	tryagaintexture.visible = false
	try_again_button.visible = false
	result_label.visible = false
	complete_texture.visible = false
	exit_button.visible = false

func load_json_data():
	var file_path = "res://jsonFile/QuestionnaireJsonFile/questions.json"
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if file:
		var json_text = file.get_as_text()
		var json = JSON.new()
		var error = json.parse(json_text)
		
		if error == OK:
			var data = json.get_data()
			if data.has("questions"):
				questions = data["questions"]
				display_question(0)
		else:
			print("JSON Parse Error: ", json.get_error_message())
	else:
		print("Failed to open file")

func display_question(index):
	if index >= 0 and index < questions.size():
		var question_data = questions[index]
		QuestionLabel.text = question_data["question"]
		correct_answers = question_data["correct_answer"]
		
		var options = question_data["options"]
		Choice1Label.text = options[0]
		Choice2Label.text = options[1]
		Choice3Label.text = options[2]
		Choice4Label.text = options[3]
		
		result_label.text = ""

func check_answer(selected_answer):
	if selected_answer == correct_answers:
		result_label.text = "Correct!"
	else:    #Handles if the answer is wrong
		texture_rect.visible = false
		QuestionLabel.visible = false
		panel_container.visible = false
		tryagaintexture.visible = true
		try_again_button.visible = true
	
	await get_tree().create_timer(0.2).timeout
	
	if current_question_index < questions.size() - 1:
		current_question_index += 1
		display_question(current_question_index)
	else:
		texture_rect.visible = false
		QuestionLabel.visible = false
		panel_container.visible = false
		tryagaintexture.visible = false
		try_again_button.visible = false
		complete_texture.visible = true
		exit_button.visible = true

func _on_option_1_pressed() -> void:
	check_answer(Choice1Label.text)

func _on_option_2_pressed() -> void:
	check_answer(Choice2Label.text)

func _on_option_3_pressed() -> void:
	check_answer(Choice3Label.text)

func _on_option_4_pressed() -> void:
	check_answer(Choice4Label.text)

func _on_try_again_pressed() -> void:
	current_question_index = 0
	display_question(0)
	tryagaintexture.visible = false
	try_again_button.visible = false
	texture_rect.visible = true
	QuestionLabel.visible = true
	panel_container.visible = true
	result_label.text = ""

func _on_exit_pressed() -> void:
	PlayerManager.player.handle_quiz(false)
	queue_free()
