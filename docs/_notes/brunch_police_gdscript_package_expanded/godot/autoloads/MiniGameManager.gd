extends Node
class_name MiniGameManager

enum MiniGameState { IDLE, RUNNING, COMPLETED, FAILED }

signal minigame_registered(id: String)
signal minigame_started(id: String)
signal minigame_completed(id: String, score: int)
signal minigame_failed(id: String)
signal minigame_updated(id: String, data: Dictionary)

var minigames: Dictionary = {}

func register_minigame(id: String, data: Dictionary = {}) -> void:
	minigames[id] = {
		"state": MiniGameState.IDLE,
		"type": data.get("type", "generic"),
		"time_limit": float(data.get("time_limit", 0.0)),
		"time_remaining": float(data.get("time_limit", 0.0)),
		"score": int(data.get("score", 0)),
		"data": data.duplicate(true)
	}
	minigame_registered.emit(id)

func _process(delta: float) -> void:
	for id in minigames.keys():
		var game: Dictionary = minigames[id]
		if int(game["state"]) != MiniGameState.RUNNING:
			continue
		if float(game["time_limit"]) > 0.0:
			game["time_remaining"] = maxf(0.0, float(game["time_remaining"]) - delta)
			if float(game["time_remaining"]) <= 0.0:
				minigames[id] = game
				fail_minigame(id)
			else:
				minigames[id] = game
				minigame_updated.emit(id, game.duplicate(true))

func start_minigame(id: String) -> void:
	if not minigames.has(id):
		return
	minigames[id]["state"] = MiniGameState.RUNNING
	minigames[id]["time_remaining"] = minigames[id]["time_limit"]
	minigame_started.emit(id)

func add_score(id: String, amount: int) -> void:
	if not minigames.has(id):
		return
	minigames[id]["score"] = int(minigames[id]["score"]) + amount
	minigame_updated.emit(id, minigames[id].duplicate(true))

func complete_minigame(id: String, score_override: int = -1) -> void:
	if not minigames.has(id):
		return
	if score_override >= 0:
		minigames[id]["score"] = score_override
	minigames[id]["state"] = MiniGameState.COMPLETED
	minigame_completed.emit(id, int(minigames[id]["score"]))

func fail_minigame(id: String) -> void:
	if not minigames.has(id):
		return
	minigames[id]["state"] = MiniGameState.FAILED
	minigame_failed.emit(id)

func reset_minigame(id: String) -> void:
	if not minigames.has(id):
		return
	minigames[id]["state"] = MiniGameState.IDLE
	minigames[id]["score"] = 0
	minigames[id]["time_remaining"] = minigames[id]["time_limit"]

func get_minigame(id: String) -> Dictionary:
	return minigames.get(id, {}).duplicate(true)
