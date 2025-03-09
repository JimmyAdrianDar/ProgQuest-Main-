class_name book extends Control

@export var book_2 : NodePath
var Book2

func _ready() -> void:
	Book2 = get_node(book_2)

func _on_next_pressed() -> void:
	if Book2:
		Book2.visible = true
		self.visible = false
