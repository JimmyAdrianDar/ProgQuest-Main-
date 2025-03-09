class_name book3 extends Control

@export var book_4 : NodePath
var Book4

func _ready() -> void:
	Book4 = get_node(book_4)

func _on_next_pressed() -> void:
	if Book4:
		Book4.visible = true
		self.visible = false
