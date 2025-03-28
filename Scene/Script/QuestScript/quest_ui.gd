class_name QuestsUI extends Control

const QUEST_ITEM : PackedScene = preload("res://Scene/Scene/QuestScene/quest_item.tscn")

@onready var quest_item_container: VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer

var is_visible : bool = false

func _ready() -> void:
	visible = false
	visibility_changed.connect(_on_visible_changed)
	pass

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("exit") and not is_visible:
		visible = true
		is_visible = true
	elif Input.is_action_just_pressed("exit") and is_visible:
		visible = false
		is_visible = false

func _on_visible_changed() -> void:
	for i in quest_item_container.get_children():
		i.queue_free()
	
	if visible == true:
		QuestManager.sort_quests()
		for q in QuestManager.current_quests:
			var quest_data : Quest = QuestManager.find_quest_by_title(q.title)
			if quest_data == null:
				continue
			var new_q_item : QuestItem = QUEST_ITEM.instantiate()
			quest_item_container.add_child(new_q_item)
			new_q_item.initialize(quest_data, q)
	pass
