extends Control

var mainMenu_scene = preload("res://MainMenu.tscn")

func _ready() -> void:
	$"../AnimationPlayer".play("open_settings")

func _on_back_button_pressed() -> void:
	$"../AnimationPlayer".play("close_settings")
	if $"../AnimationPlayer".animation_finished:
		get_tree().change_scene_to_file("res://MainMenu.tscn")

func _on_mute_or_un_mute_pressed() -> void:
	var master_bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus_index, !AudioServer.is_bus_mute(master_bus_index))
	
# Mute / Unmute Thingy - Dont Change Hard To Fix heheh (connected to Index)
#Add Slider Here, Bugs Connected to Main Game cant - Fix srry :(





# SAMPLE CODE BELOW *-*







#----------------------------------------------------------------------------------------------------------------------



func _on_master_value_changed(value: float):
	set_volume(0, value)

func set_volume(idx, value):
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))

func _on_sound_sfx_value_changed(value):
	set_volume(2, value)


func _on_music_value_changed(value):
	set_volume(1, value)
