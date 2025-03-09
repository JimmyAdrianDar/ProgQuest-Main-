class_name book2 extends Control

@export var book_3 : NodePath
var Book3

func _ready() -> void:
	Book3 = get_node(book_3)

func _on_next_pressed() -> void:
	if Book3:
		Book3.visible = true
		self.visible = false
