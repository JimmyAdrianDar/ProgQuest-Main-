extends Node2D

@onready var interactive_area: InteractionArea = $InteractionArea 
@onready var sprite = $Sprite2D

var interact_count : int = 0

func _ready() -> void:
	interactive_area.interact = Callable(self, "_on_interact")
	Dialogic.timeline_ended.connect(_on_tiimeline_ended)

func _on_interact():
	if !interact_count >= 1:
		Dialogic.start("npc")
		return
	elif interact_count == 1:
		Dialogic.start("AfterSlimeQuest")
		return
	elif interact_count == 2:
		PlayerManager.player.handle_book(true)
		interact_count += 1
		return
	elif interact_count == 3:
		Dialogic.start("AfterReading")
		return
	elif interact_count == 4:
		PlayerManager.player.handle_quiz(true)

func _on_tiimeline_ended():
	interact_count += 1
