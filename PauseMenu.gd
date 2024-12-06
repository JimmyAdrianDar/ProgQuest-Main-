extends Button


func _on_pressed() -> void:
	get_tree().change_scene_to_file("")
# Add Current Game Run Time

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("")
# Add Scene of Game Restarted

func _on_quit_game_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
