extends Node2D

@onready var interactive_area: InteractionArea = $InteractionArea 
@onready var sprite = $Sprite2D


func _ready() -> void:
	interactive_area.interact = Callable(self, "_on_interact")

func _on_interact():
	#Dialogic.start("npc")
	PlayerManager.player.handle_quiz(true)
