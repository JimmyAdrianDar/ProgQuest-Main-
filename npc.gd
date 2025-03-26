extends Node2D

signal give_quest

@onready var interactive_area: InteractionArea = $InteractionArea 
@onready var sprite = $Sprite2D
@onready var player: Player = $"../Player"

var has_quest : bool = false
var interact_count : int = 0
var waiting_for_timeline : bool = false


func _ready() -> void:
	interactive_area.interact = Callable(self, "_on_interact")
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_interact():
	if interact_count == 0:
		Dialogic.start("BobStartingQuest")
		waiting_for_timeline = true
	elif interact_count == 1:
		Dialogic.start("BobOnTheTreesQuest")
		give_quest.emit()
		has_quest = true
	elif interact_count == 2 and not has_quest:
		Dialogic.start("BobDoneQuest")

	# Check if the quest is complete
	if has_quest and player.slime_killed == 5:
		has_quest = false  # Reset the quest state

	# Only increment interact_count if the quest is not active
	if not has_quest:
		interact_count += 1
	_on_timeline_ended()
	
func _on_timeline_ended():
	PlayerManager.player.navigation_target_postion = Vector2(-737, -970)
	position = Vector2(-652, -1115)
	
	#What is 1 on _on_interact is equal to 2 here.
	if interact_count == 1 and has_quest:
		PlayerManager.player.navigation_target_postion = Vector2(-1039, 69)
	if interact_count == 2:
		PlayerManager.player.navigation_target_postion = Vector2(2447, 264)
