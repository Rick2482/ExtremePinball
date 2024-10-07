class_name RunStats
extends Resource

@export var score := 0 : set = set_score

func set_score(new_score: int):
	score = new_score
	Events.score_changed.emit()
