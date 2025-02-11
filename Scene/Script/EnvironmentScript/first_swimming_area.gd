extends Area2D
var is_body_entered

func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	is_body_entered = body

func _on_body_exited(body: Node2D) -> void:
	is_body_entered = null

func _process(delta: float) -> void:
	if is_body_entered != null:
		if is_body_entered.has_method("receive_swimming_notification"):
			is_body_entered.receive_swimming_notification(true)
