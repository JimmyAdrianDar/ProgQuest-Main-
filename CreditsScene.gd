extends Button

func _ready() -> void:
	$"../../AnimationPlayer".play("open_credits")

func _on_pressed() -> void:
	$"../../AnimationPlayer".play("close_credits")
	if $"../../AnimationPlayer".animation_finished:
		get_tree().change_scene_to_file("res://MainMenu.tscn")
