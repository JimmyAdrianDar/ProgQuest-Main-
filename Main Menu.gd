extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file("")
# Add Scene to Main Game

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://SettingScene.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://CreditsSene.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
