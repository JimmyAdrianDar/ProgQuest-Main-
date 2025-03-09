class_name book4 extends Control

func _on_next_pressed() -> void:
	PlayerManager.player.handle_book(false)
	queue_free()
