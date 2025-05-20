extends Button

var settings_scene = preload("res://SettingScene.tscn")
var creddits_scene = preload("res://CreditsSene.tscn")

func _ready() -> void:
	$"../../../../AnimationPlayer".play("open_menu")

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
# Add Scene to Main Game

func _on_settings_button_pressed() -> void:
	$"../../../../AnimationPlayer".play("close_menu")
	
	if $"../../../../AnimationPlayer".animation_finished:
		get_tree().change_scene_to_packed(settings_scene)

func _on_credits_pressed() -> void:
	$"../../../../AnimationPlayer".play("close_menu")
	
	if $"../../../../AnimationPlayer".animation_finished:
		get_tree().change_scene_to_packed(creddits_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
