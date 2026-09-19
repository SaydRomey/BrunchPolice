extends Node
class_name ScoreManager

signal score_changed(score: int, delta: int)

var score: int = 0

func add_score(points: int) -> void:
	if points == 0:
		return
	score += points
	score_changed.emit(score, points)

func subtract_score(points: int) -> void:
	if points <= 0:
		return
	score = max(0, score - points)
	score_changed.emit(score, -points)

func set_score(value: int) -> void:
	var old_score := score
	score = max(0, value)
	score_changed.emit(score, score - old_score)

func get_score() -> int:
	return score

func reset_score() -> void:
	set_score(0)
