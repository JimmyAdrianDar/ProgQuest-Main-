class_name book4 extends Control

@onready var canvas_layer: CanvasLayer = $".."


func _on_next_pressed() -> void:
	canvas_layer.queue_free()
	PlayerManager.player.ui_disable(false)
