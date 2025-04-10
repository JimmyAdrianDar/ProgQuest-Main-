class_name QuestsUI
extends Control

const QUEST_ITEM: PackedScene = preload("res://Scene/Scene/QuestScene/quest_item.tscn")

@onready var quest_item_container: VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer

var is_visible: bool = false

func _ready() -> void:
	visible = false
	visibility_changed.connect(_on_visibility_changed)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		is_visible = not is_visible
		visible = is_visible

	# Optional: update quests while open
	if is_visible:
		update_quests()  # You can remove this if you want manual control

func _on_visibility_changed() -> void:
	update_quests()

func update_quests() -> void:
	# Clear old quest items
	for child in quest_item_container.get_children():
		child.queue_free()

	if not visible:
		return

	# Re-populate quest list
	QuestManager.sort_quests()
	for quest_status in QuestManager.current_quests:
		var quest_data: Quest = QuestManager.find_quest_by_title(quest_status.title)
		if quest_data == null:
			continue
		var quest_item: QuestItem = QUEST_ITEM.instantiate()
		quest_item_container.add_child(quest_item)
		quest_item.initialize(quest_data, quest_status)
