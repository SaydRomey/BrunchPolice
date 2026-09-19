extends Node
class_name QuestObjectiveManager

enum ObjectiveState { INACTIVE, ACTIVE, COMPLETED, FAILED }

signal quest_started(quest_id: String)
signal quest_completed(quest_id: String)
signal quest_failed(quest_id: String)
signal objective_updated(quest_id: String, objective_id: String, data: Dictionary)
signal objective_completed(quest_id: String, objective_id: String)

var quests: Dictionary = {}

func register_quest(quest_id: String, title: String, objectives: Array[Dictionary]) -> void:
	quests[quest_id] = {
		"title": title,
		"state": ObjectiveState.INACTIVE,
		"objectives": {}
	}
	for objective in objectives:
		var id := String(objective.get("id", ""))
		if id.is_empty():
			continue
		quests[quest_id]["objectives"][id] = {
			"description": objective.get("description", id),
			"target": int(objective.get("target", 1)),
			"progress": int(objective.get("progress", 0)),
			"state": ObjectiveState.ACTIVE if bool(objective.get("active", true)) else ObjectiveState.INACTIVE
		}

func start_quest(quest_id: String) -> void:
	if not quests.has(quest_id):
		return
	quests[quest_id]["state"] = ObjectiveState.ACTIVE
	quest_started.emit(quest_id)

func update_objective(quest_id: String, objective_id: String, amount: int = 1) -> void:
	if not _has_objective(quest_id, objective_id):
		return
	var objective: Dictionary = quests[quest_id]["objectives"][objective_id]
	if int(objective["state"]) != ObjectiveState.ACTIVE:
		return
	objective["progress"] = mini(int(objective["target"]), int(objective["progress"]) + amount)
	quests[quest_id]["objectives"][objective_id] = objective
	objective_updated.emit(quest_id, objective_id, objective.duplicate(true))
	if int(objective["progress"]) >= int(objective["target"]):
		complete_objective(quest_id, objective_id)

func complete_objective(quest_id: String, objective_id: String) -> void:
	if not _has_objective(quest_id, objective_id):
		return
	quests[quest_id]["objectives"][objective_id]["state"] = ObjectiveState.COMPLETED
	objective_completed.emit(quest_id, objective_id)
	if _all_objectives_completed(quest_id):
		complete_quest(quest_id)

func complete_quest(quest_id: String) -> void:
	if not quests.has(quest_id):
		return
	quests[quest_id]["state"] = ObjectiveState.COMPLETED
	quest_completed.emit(quest_id)

func fail_quest(quest_id: String) -> void:
	if not quests.has(quest_id):
		return
	quests[quest_id]["state"] = ObjectiveState.FAILED
	quest_failed.emit(quest_id)

func get_active_quests() -> Dictionary:
	var active := {}
	for quest_id in quests.keys():
		if int(quests[quest_id]["state"]) == ObjectiveState.ACTIVE:
			active[quest_id] = quests[quest_id].duplicate(true)
	return active

func get_quest(quest_id: String) -> Dictionary:
	return quests.get(quest_id, {}).duplicate(true)

func _has_objective(quest_id: String, objective_id: String) -> bool:
	return quests.has(quest_id) and quests[quest_id].has("objectives") and quests[quest_id]["objectives"].has(objective_id)

func _all_objectives_completed(quest_id: String) -> bool:
	for objective_id in quests[quest_id]["objectives"].keys():
		if int(quests[quest_id]["objectives"][objective_id]["state"]) != ObjectiveState.COMPLETED:
			return false
	return true
