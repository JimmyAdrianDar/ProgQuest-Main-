class_name Marcos extends Node2D

signal give_quest
signal finish_quest

@onready var interactive_area: InteractionArea = $InteractionArea 
@onready var sprite = $Sprite2D
@onready var player: Player = $"../Player"
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var book: book = $CanvasLayer/Book

var active_timeline : String = ""
var has_quest : bool = false
var interact_count : int = 0

func _ready() -> void:
	interactive_area.interact = Callable(self, "_on_interact")
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_interact():
	if interact_count == 0:
		PlayerManager.player.dialogue_ui_visibility(false)
		active_timeline = "marcosdialogue"
		timeline(active_timeline)
		give_quest.emit()
	if interact_count == 1:
		PlayerManager.player.dialogue_ui_visibility(false)
		active_timeline = "marcosEndGate"
		timeline(active_timeline)
		give_quest.emit()
	if interact_count == 2:
		PlayerManager.player.dialogue_ui_visibility(false)
		active_timeline = "MarcosOnBossGate"
		timeline(active_timeline)

func quest_on_martha_finished(is_finished : bool):
	if is_finished == true:
		finish_quest.emit()
		interact_count += 1

func timeline(timeline_active : String):
	Dialogic.start(timeline_active)

func _on_timeline_ended():
	if active_timeline == "marcosdialogue":
		PlayerManager.player.dialogue_ui_visibility(true)
		active_timeline = ""
		
		interact_count += 1
		
		await get_tree().create_timer(2).timeout
		$Area2D.visible = true
	if active_timeline == "marcosEndGate":
		position = Vector2(2471.0, 7.0)
		PlayerManager.player.dialogue_ui_visibility(true)
		PlayerManager.player.quest_arrow_target_position(2471.0, 7.0)
		PlayerManager.player.quest_arrow_visibility(true)
		
		active_timeline = ""
		interact_count += 1
		
		PlayerManager.player.bag.visible = true
		
		await get_tree().create_timer(2).timeout
		$Area2D.visible = true
	if active_timeline == "MarcosOnBossGate":
		PlayerManager.player.dialogue_ui_visibility(true)
		active_timeline = ""
		interact_count += 1
		
		await get_tree().create_timer(2).timeout
		$Area2D.visible = true

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body:
		if interact_count >= 0:
			PlayerManager.player.quest_arrow_target_position(0.0, 0.0)
			PlayerManager.player.quest_arrow_visibility(false)
			$Area2D.visible = false
