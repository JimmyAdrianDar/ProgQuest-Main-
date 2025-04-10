@tool
class_name QuestAdvanceTrigger extends QuestNode

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	pass

func advance_quest() -> void:
	if linked_quest == null:
		return
	
	var _title : String = linked_quest.title
	var _step : String = get_step()
	
	if _step == "N/A":
		_step = ""
	
	QuestManager.update_quest(_title, _step, quest_complete)
	pass
