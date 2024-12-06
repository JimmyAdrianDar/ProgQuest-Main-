extends Control


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_mute_or_un_mute_pressed() -> void:
	var master_bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus_index, !AudioServer.is_bus_mute(master_bus_index))
	
# Mute / Unmute Thingy - Dont Change Hard To Fix heheh (connected to Index)
#Add Slider Here, Bugs Connected to Main Game cant - Fix srry :(





# SAMPLE CODE BELOW *-*







#----------------------------------------------------------------------------------------------------------------------



#var master_bus = AudioServer.get_bus_index("Master")


#func _on_h_slider_value_changed(value: float) -> void:
#AudioServer.set_bus_volume_db(master_bus, value)
#if value == -31:
#AudioServer.set_bus_mute(master_bus, true)
#else:
#AudioServer.set_bus_mute(master_bus, false)
