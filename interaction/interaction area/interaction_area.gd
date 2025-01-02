extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"


func _ready() -> void:
	Global.player_interacting = false

var interact: Callable = func ():
	pass


func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)
	Global.player_interacting = true


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
	Global.player_interacting = false
