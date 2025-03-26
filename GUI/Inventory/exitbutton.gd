extends Button

func _ready() -> void:
	get_viewport().set_input_as_handled()
	grab_focus()
	pressed.connect(press)
	pass

func press():
	print("exitbuttonpressed")
