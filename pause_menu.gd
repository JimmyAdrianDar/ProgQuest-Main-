extends Control

@onready var pausemenu = $"."

func _ready() -> void:
	pausemenu.visible = false

func _process(delta: float) -> void:
	testSettings()

func resume():
	get_tree().paused = false
	pausemenu.visible = false

func pause():
	get_tree().paused = true
	pausemenu.visible = true

func testSettings():
	if Input.is_action_just_pressed("settings") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("settings") and get_tree().paused:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_quit_game_pressed() -> void:
	resume() #fixes the bug of when press quit and back to menu and press start again and it pauses
	get_tree().change_scene_to_file("res://MainMenu.tscn")
