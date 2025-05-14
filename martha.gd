extends Node2D

signal give_quest

@onready var interactive_area: InteractionArea = $InteractionArea 
@onready var sprite = $Sprite2D
@onready var player: Player = $"../Player"
@onready var is_quest_complete: PersistentDataHandler = $IsQuestComplete

var active_timeline : String = ""
var interact_count : int = 0


func _ready() -> void:
	interactive_area.interact = Callable(self, "_on_interact")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	is_quest_complete.data_loaded.connect(set_quest_state)

func set_quest_state() -> void:
	pass

func _on_interact():
	if interact_count == 0:
		PlayerManager.player.dialogue_ui_visibility(false)
		active_timeline = "MarthaStory"
		timeline(active_timeline)

func timeline(timeline_active : String):
	Dialogic.start(timeline_active)

func _on_timeline_ended():
	if active_timeline == "MarthaStory":
		PlayerManager.player.dialogue_ui_visibility(true)
		active_timeline = ""
		
		is_quest_complete.set_value()
		
		PlayerManager.player.dialogue_ui_visibility(true)
		PlayerManager.player.quest_arrow_target_position(2899.0, -808.0)
		PlayerManager.player.quest_arrow_visibility(true)
		active_timeline = ""
		
		print("Martha emitted quest finished")
		
		await get_tree().create_timer(2).timeout
		$Area2D.visible = true


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body:
		if interact_count >= 0:
			PlayerManager.player.quest_arrow_target_position(0.0, 0.0)
			PlayerManager.player.quest_arrow_visibility(false)
			$Area2D.visible = false
