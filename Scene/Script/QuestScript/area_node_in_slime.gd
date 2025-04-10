extends Area2D

@onready var npc: Node2D = $"../../CharacterContainer/Npc"
var once : int = 0

func _on_body_entered(body: Player) -> void:
	if body and not once > 0:
		npc._on_interactive_area_body_entered(body)
		once += 1
		print("once: ", once)
