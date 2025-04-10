extends CanvasLayer

func _process(delta: float) -> void:
	pressed()

func pressed():
	if Input.is_action_just_pressed("book"):
		PlayerManager.player.all_control_viisbility(false)
		$Book.visible = true
	
