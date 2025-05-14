class_name book4 extends Control

@onready var canvas_layer: CanvasLayer = $".."

func _on_next_pressed() -> void:
	$"../Book".visible = false
	$"../Book2".visible = false
	$"../Book3".visible = false
	$".".visible = false
	PlayerManager.player.all_book_visibility(true)
