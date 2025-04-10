extends Node2D

signal give_quest
signal killed_1
signal killed_2
signal killed_3
signal killed_4
signal killed_5

@onready var interactive_area: InteractionArea = $InteractionArea 
@onready var sprite = $Sprite2D
@onready var player: Player = $"../Player"

var has_quest : bool = false
var interact_count : int = 0
var waiting_for_timeline : bool = false

var quest_arrow_visibility : bool 

var active_timeline : String = ""

func _ready() -> void:
	interactive_area.interact = Callable(self, "_on_interact")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	$InteractiveArea.visible = false

func _process(delta: float) -> void:
	if PlayerManager.player.slime_killed == 1:
		killed_1.emit()
	if PlayerManager.player.slime_killed == 2:
		killed_2.emit()
	if PlayerManager.player.slime_killed == 3:
		killed_3.emit()
	if PlayerManager.player.slime_killed == 4:
		killed_4.emit()
	if PlayerManager.player.slime_killed == 5:
		killed_5.emit()
		if interact_count == 1:
			PlayerManager.player.quest_arrow_visibility(true)
			PlayerManager.player.quest_arrow_target_position(-589.0, -1046.0)
			
			await get_tree().create_timer(1).timeout
			if interact_count == 1:
				interact_count += 1
				return
			

func _on_interact():
	if interact_count == 0:
		PlayerManager.player.dialogue_ui_visibility(false)
		active_timeline = "BobStartingQuest"
		timeline(active_timeline)
	elif interact_count == 1:
		PlayerManager.player.dialogue_ui_visibility(false)
		active_timeline = "BobOnTheTreesQuest"
		timeline(active_timeline)
		give_quest.emit()
		has_quest = true
	elif interact_count == 2:
		PlayerManager.player.dialogue_ui_visibility(false)
		active_timeline = "BobDoneQuest"
		timeline(active_timeline)
		
	elif interact_count == 3:
		PlayerManager.player.dialogue_ui_visibility(false)
		active_timeline = ""
		timeline(active_timeline)
#
	## Only increment interact_count if the quest is not active
	#if not has_quest:
		#interact_count += 1
	#_on_timeline_ended()
	print(interact_count)

func timeline(timeline_active : String):
	Dialogic.start(timeline_active)

func _on_timeline_ended():
	if active_timeline == "BobStartingQuest":
		position = Vector2(-652, -1115)
		PlayerManager.player.dialogue_ui_visibility(true)
		PlayerManager.player.quest_arrow_target_position(-589.0, -1046.0)
		PlayerManager.player.quest_arrow_visibility(true)
		active_timeline = ""
		interact_count += 1
		
		await get_tree().create_timer(2).timeout
		$InteractiveArea.visible = true
	if active_timeline == "BobOnTheTreesQuest":
		PlayerManager.player.dialogue_ui_visibility(true)
		PlayerManager.player.quest_arrow_target_position(-1064.0, 180)
		PlayerManager.player.quest_arrow_visibility(true)
		active_timeline = ""
		
		#PlayerManager.player.exitbutton.visible = true
		
		await get_tree().create_timer(2).timeout
		$InteractiveArea.visible = true
	if active_timeline == "BobDoneQuest":
		PlayerManager.player.dialogue_ui_visibility(true)
		PlayerManager.player.quest_arrow_target_position(-1756.0, 2107.0)
		PlayerManager.player.quest_arrow_visibility(true)
		active_timeline = ""
		
		await get_tree().create_timer(2).timeout
		$InteractiveArea.visible = true

func _on_interactive_area_body_entered(body: CharacterBody2D) -> void:
	if body:
		if interact_count > 0:
			PlayerManager.player.quest_arrow_target_position(0.0, 0.0)
			PlayerManager.player.quest_arrow_visibility(false)
			$InteractiveArea.visible = false
