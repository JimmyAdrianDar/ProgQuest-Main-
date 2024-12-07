extends Button

func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true

func testEsc():
	if Input.is_action_just_pressed("settings") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("settings") and get_tree().paused:
		resume()

func _on_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _process(delta: float) -> void:
	testEsc()
